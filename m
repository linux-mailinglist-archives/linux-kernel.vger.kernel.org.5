Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1787CCA41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjJQSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjJQSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:02:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2698
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:02:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c52289e900so4435601fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697565721; x=1698170521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faMsIPVgEsi38B8ugABdV0PePmMuwFh46wQeSoEie0k=;
        b=edTve8iV0i4Mt1yVL71BeRTITYwWUnSz3LQa4dA38pjHAu816PUAevZU3gcLQkbajC
         FcpQv9Qdd5dlILBIRTXLkZlpCMAag3cVZ61jv0rFCbsGFmU9kFbvQ1CJrh8abnGPAxnj
         /R3gBWD3i+1s/qDuwPtTWCh31TUfoFCxUVqNC0ebjvB9bNrz3A7s/NKq83jzlpQGSaYB
         APvB0ddSImPHYHV0zCMi5D1bFCIDg+zndok7dshpDokhetHYAwuKW/Gv1+USfgEBIHoO
         0KswVtEyKFl8WHS9UGVS25a8uXheofcVW+HU2/xVdW698mJAAo9hUdtw195RqA/ME3xg
         XSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565721; x=1698170521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faMsIPVgEsi38B8ugABdV0PePmMuwFh46wQeSoEie0k=;
        b=lLvqpL+VM3yXdJ+Pjwkon4TZ2UVodj7qqg65cD9eRXZ+ABaKcdtdqeJZpDDiaT46H8
         Fnk7Q+qMqfrnxD1csL1afOaYy6pUXhycFHQjTWLm6UC96R4Ex9CHWwEDfsDk9TxrkgRF
         4siYzfxpqfVSR0U7FXi4AGoiUF0PY5cycf8JegYZpggY8flSRfl4u0NRGSEUiffyJvNS
         mZrjHqEI+cVwMvDzelVuR5kciqTUXRB3sR0V2HGoF8oZtU2zTzMVHGaaPRdA7AGMVkDK
         tenj5nBNtg2vMPHh62VsKZJVikw81qeI1mcC5L1tl3StpjIZlpdguABvap1JNp7Fxti3
         ZOWg==
X-Gm-Message-State: AOJu0YyNq1jGP2kMAQ1LpYbL639KieDLCSNJ/Q9UZO6iCpzu5MNkatxP
        R3GB2+6v50/1Q7L9tP71a+hTPdtOAeM=
X-Google-Smtp-Source: AGHT+IH1QSCIJPjzuJWDEsOHlsJ4V7qM9R63EKVudpwzixCUngsIDvDMEhOHCshRKlUIlAp1SJW0dw==
X-Received: by 2002:a17:907:3da2:b0:9c3:cefa:93c9 with SMTP id he34-20020a1709073da200b009c3cefa93c9mr2659171ejc.1.1697565700782;
        Tue, 17 Oct 2023 11:01:40 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bm4-20020a170906c04400b009c46445fcc7sm212321ejb.33.2023.10.17.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:01:40 -0700 (PDT)
Message-ID: <fc5aca64-d3c1-46f9-bcff-1f9bd5c6fc41@gmail.com>
Date:   Tue, 17 Oct 2023 20:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr
 and byBBPreEDRSSI
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        forest@alittletooquiet.net, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
 <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
 <2023101747-goal-curing-5577@gregkh>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2023101747-goal-curing-5577@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 15:40, Greg KH wrote:
> On Tue, Oct 17, 2023 at 08:19:49AM +0200, Philipp Hortmann wrote:
>> On 10/17/23 00:58, Gilbert Adikankwu wrote:
>>> Make the variable names adhere to Linux kernel coding style and mute
>>> checkpatch.pl errors.
>>>
>>> Gilbert Adikankwu (4):
>>>     staging: vt6655: Rename variable bUpdateBBVGA
>>>     staging: vt6655: Rename variable byCurrentCh
>>>     staging: vt6655: Rename variable byCurPwr
>>>     staging: vt6655: Rename variable byBBPreEDRSSI
>>>
>>>    drivers/staging/vt6655/baseband.c    |  2 +-
>>>    drivers/staging/vt6655/channel.c     | 18 +++++++++---------
>>>    drivers/staging/vt6655/device.h      |  8 ++++----
>>>    drivers/staging/vt6655/device_main.c |  8 ++++----
>>>    drivers/staging/vt6655/dpc.c         |  2 +-
>>>    drivers/staging/vt6655/rf.c          |  4 ++--
>>>    6 files changed, 21 insertions(+), 21 deletions(-)
>>>
>>
>> Hi,
>>
>> -       if (priv->byCurrentCh == ch->hw_value)
>> +       if (priv->current_ch == ch->hw_value)^M
>>                  return ret;
>>
>> ERROR: DOS line endings
>>
>> What does the "^M" at the end of the new line?
>> Did you run checkpatch on your patches?
> 
> I don't see that on my side, are you sure this is there?
> 
> thanks,
> 
> greg k-h


Hi,

as previously assumed: yes I saved the email from Thunderbird to Downloads:

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply 
--reject --ignore-space-change --ignore-whitespace ~/Downloads/\[PATCH\ 1*
Checking patch drivers/staging/vt6655/baseband.c...
Checking patch drivers/staging/vt6655/channel.c...
Checking patch drivers/staging/vt6655/device.h...
Checking patch drivers/staging/vt6655/device_main.c...
Applied patch drivers/staging/vt6655/baseband.c cleanly.
Applied patch drivers/staging/vt6655/channel.c cleanly.
Applied patch drivers/staging/vt6655/device.h cleanly.
Applied patch drivers/staging/vt6655/device_main.c cleanly.
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git diff
diff --git a/drivers/staging/vt6655/baseband.c 
b/drivers/staging/vt6655/baseband.c
index 7d47b266b87e..4fe7b6856c29 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2087,7 +2087,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
                 /* {{ RobertYu: 20050104 */
         } else {
                 /* No VGA Table now */
-               priv->bUpdateBBVGA = false;
+               priv->update_bbvga = false;^M
                 priv->bbvga[0] = 0x1C;
         }

diff --git a/drivers/staging/vt6655/channel.c 
b/drivers/staging/vt6655/channel.c
index 6ac7d470c041..0e1ca481f976 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -86,7 +86,7 @@ bool set_channel(struct vnt_private *priv, struct 
ieee80211_channel *ch)
                 return ret;

         /* Set VGA to max sensitivity */
-       if (priv->bUpdateBBVGA &&
+       if (priv->update_bbvga &&^M
             priv->bbvga_current != priv->bbvga[0]) {
                 priv->bbvga_current = priv->bbvga[0];

diff --git a/drivers/staging/vt6655/device.h 
b/drivers/staging/vt6655/device.h
index 68bfadacfa7c..7b8fb2aad08a 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -246,7 +246,7 @@ struct vnt_private {
         unsigned char byAutoFBCtrl;

         /* For Update BaseBand VGA Gain Offset */
-       bool bUpdateBBVGA;
+       bool update_bbvga;^M
         unsigned int    uBBVGADiffCount;
         unsigned char bbvga_new;
         unsigned char bbvga_current;
diff --git a/drivers/staging/vt6655/device_main.c 
b/drivers/staging/vt6655/device_main.c
index b08fcf7e6edc..dd6ac8a3cc29 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -179,7 +179,7 @@ device_set_options(struct vnt_private *priv)
         priv->byBBType = priv->opts.bbp_type;
         priv->byPacketType = priv->byBBType;
         priv->byAutoFBCtrl = AUTO_FB_0;
-       priv->bUpdateBBVGA = true;
+       priv->update_bbvga = true;^M
         priv->preamble_type = 0;

         pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
@@ -423,7 +423,7 @@ static void device_init_registers(struct vnt_private 
*priv)
         /* initialize BBP registers */
         bb_vt3253_init(priv);

-       if (priv->bUpdateBBVGA) {
+       if (priv->update_bbvga) {^M
                 priv->bbvga_current = priv->bbvga[0];
                 priv->bbvga_new = priv->bbvga_current;
                 bb_set_vga_gain_offset(priv, priv->bbvga[0]);
@@ -1040,7 +1040,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
         long dbm;
         int i;

-       if (!priv->bUpdateBBVGA)
+       if (!priv->update_bbvga)^M
                 return;

         if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git add .
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git commit 
-m "test"
WARNING: Missing commit description - Add an appropriate one

ERROR: DOS line endings
#16: FILE: drivers/staging/vt6655/baseband.c:2090:
+^I^Ipriv->update_bbvga = false;^M$

ERROR: DOS line endings
#29: FILE: drivers/staging/vt6655/channel.c:89:
+^Iif (priv->update_bbvga &&^M$

ERROR: DOS line endings
#42: FILE: drivers/staging/vt6655/device.h:249:
+^Ibool update_bbvga;^M$

ERROR: DOS line endings
#55: FILE: drivers/staging/vt6655/device_main.c:182:
+^Ipriv->update_bbvga = true;^M$

ERROR: DOS line endings
#64: FILE: drivers/staging/vt6655/device_main.c:426:
+^Iif (priv->update_bbvga) {^M$

ERROR: DOS line endings
#73: FILE: drivers/staging/vt6655/device_main.c:1043:
+^Iif (!priv->update_bbvga)^M$

ERROR: Missing Signed-off-by: line(s)

total: 7 errors, 1 warnings, 0 checks, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

"[PATCH] test" has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
[staging-testing 0e62bfff3764] test
  4 files changed, 6 insertions(+), 6 deletions(-)
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Other patch:
Same issue

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git diff
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c 
b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index ec8edfecdb73..47c01979e91f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -43,11 +43,11 @@ static u8 tx_ts_delete_ba(struct rtllib_device 
*ieee, struct tx_ts_record *pTxTs

  static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct 
rx_ts_record *ts)
  {
-       struct ba_record *pBa = &ts->rx_admitted_ba_record;
+       struct ba_record *ba = &ts->rx_admitted_ba_record;^M
         u8                      bSendDELBA = false;

-       if (pBa->b_valid) {
-               deactivate_ba_entry(ieee, pBa);
+       if (ba->b_valid) {^M
+               deactivate_ba_entry(ieee, ba);^M
                 bSendDELBA = true;
         }


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
downloaded from 
https://lore.kernel.org/linux-staging/4124e456-bad6-af50-8237-85efbba31076@inria.fr/T/#m1d8abbe97ebcba7afc5def6b318e608be22cb0d8
On right clik on Link "raw" -> "save link as..."

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply 
--reject --ignore-space-change --ignore-whitespace 
~/Downloads/PATCH-2-4-staging-vt6655-Rename-variable-byCurrentCh.txt
Checking patch drivers/staging/vt6655/channel.c...
Checking patch drivers/staging/vt6655/device.h...
Applied patch drivers/staging/vt6655/channel.c cleanly.
Applied patch drivers/staging/vt6655/device.h cleanly.
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git diff
diff --git a/drivers/staging/vt6655/channel.c 
b/drivers/staging/vt6655/channel.c
index e90e0b43505d..13bc35bd2054 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -82,7 +82,7 @@ bool set_channel(struct vnt_private *priv, struct 
ieee80211_channel *ch)
  {
         bool ret = true;

-       if (priv->byCurrentCh == ch->hw_value)
+       if (priv->current_ch == ch->hw_value)
                 return ret;

         /* Set VGA to max sensitivity */
@@ -100,7 +100,7 @@ bool set_channel(struct vnt_private *priv, struct 
ieee80211_channel *ch)
          * it is for better TX throughput
          */

-       priv->byCurrentCh = ch->hw_value;
+       priv->current_ch = ch->hw_value;
         ret &= RFbSelectChannel(priv, priv->rf_type,
                                 ch->hw_value);

@@ -117,9 +117,9 @@ bool set_channel(struct vnt_private *priv, struct 
ieee80211_channel *ch)

                 /* set HW default power register */
                 VT6655_MAC_SELECT_PAGE1(priv->port_offset);
-               RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
+               RFbSetPower(priv, RATE_1M, priv->current_ch);
                 iowrite8(priv->byCurPwr, priv->port_offset + 
MAC_REG_PWRCCK);
-               RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
+               RFbSetPower(priv, RATE_6M, priv->current_ch);
                 iowrite8(priv->byCurPwr, priv->port_offset + 
MAC_REG_PWROFDM);
                 VT6655_MAC_SELECT_PAGE0(priv->port_offset);

@@ -127,9 +127,9 @@ bool set_channel(struct vnt_private *priv, struct 
ieee80211_channel *ch)
         }

         if (priv->byBBType == BB_TYPE_11B)
-               RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
+               RFbSetPower(priv, RATE_1M, priv->current_ch);
         else
-               RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
+               RFbSetPower(priv, RATE_6M, priv->current_ch);

         return ret;
  }
diff --git a/drivers/staging/vt6655/device.h 
b/drivers/staging/vt6655/device.h
index 8c90539cc3d7..45fae21139af 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -239,7 +239,7 @@ struct vnt_private {
         bool bIsBeaconBufReadySet;
         unsigned int    cbBeaconBufReadySetCnt;
         bool bFixRate;
-       u16 byCurrentCh;
+       u16 current_ch;

         bool bAES;

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$



Sorry for the mess.

Bye Philipp


































