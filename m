Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72597BEB46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378551AbjJIUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378528AbjJIUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:08:26 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46FBA;
        Mon,  9 Oct 2023 13:08:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 24AEF5C032A;
        Mon,  9 Oct 2023 16:08:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 16:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696882103; x=1696968503; bh=Qn
        k/hYJGt8vMGvwYuS7TovawYU4FITkdWpH78jnqJOs=; b=mqCFhRXpOKbM3+gzw6
        p5PhWXSGZc4ogwVsdkuo+A43m0smOPhhYMz78yJvgnl3rvP/0KP/Yyz47bWfbLI5
        hACl6ENILilhp63gtNoE5sEtTvbwNsWX/LXMcHpkz0wzqkQE8Ndlz+z4YS7AQUAf
        GljZGp1E/6Pjf+6/oSfGUGj03jNY8coKUztcfYu6K6U7LoTipcfr2cXV0LybV0HE
        ehUr7BFFu5YfclBwoo7jtAeBLE7wuQUYAW5JBxqOd8miccBlDvavQBA9jw44/zt/
        Ge4jceNUA6w2jbKSIJ1YxQ0vJUesse+nKNVZfS7xAecqP9LaZE21UO2MfTUxCKeS
        2mjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696882103; x=1696968503; bh=Qnk/hYJGt8vMG
        vwYuS7TovawYU4FITkdWpH78jnqJOs=; b=f0ypCYly03Y1wuHi2Z6wYewa6ofwr
        rXHCSBaMW1h7QfTvDtRJwi8rU0it8is84Gbt/RLmh+5rwaZC2VGVfi5QImFok+Ag
        mEIIlgBptd4PLeaTwBDVRgIEVsFrDPX7L0GvXn9/qZu+uEHyu99V5qODgUkk7gvX
        75yD99Q0SXtM8SsEcJQK80aqK8WE+t0TR5LWxJiesFQx07hgjT26Qcgso1mdmUof
        MW7qKZq/6nH8plFrjV+oJqp0ma9r4r4s0Zu2Thn5TCQyecftNC2Di+ozRCGJBgYY
        DdWoVysC07AELOwJjOIO5+j0ZErv0f0ymPN+5W2vU8YmpSwGAXc5CpOEA==
X-ME-Sender: <xms:tl0kZdUSxlakiUfO9FFK6SiHegcIpgCKv9_8DB2jz6N7Ce5qQd6XsQ>
    <xme:tl0kZdl-k0Gh-TP5vBbEgYcrhYQ9TI38AIMhAo5a87f4OvK-4oDw6kC7dg5nOvlda
    c1_Z4IB_NosQCBIXCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeetiefhjedvhfeffffhvddvvdffgfetvdetiefghefhheduffeljeeuuddv
    lefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tl0kZZZQMIW6RWr3x42jPiC9drCxlxSK_g0DBgg366ugaUZmIf503Q>
    <xmx:tl0kZQWAJMHf0U76paad2iB94pRNxUuvsC97CJzBbRGAvmI7kBWHQA>
    <xmx:tl0kZXnEbp7Cmwm4JV61eNkY4JfK-CK2f_h4efCjSNyZWPOCFncH3A>
    <xmx:t10kZc8TvDBWITpAna4SSGxoS4f2tvuQm5AzRcXvQPuQLe_ssVA10A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 18E3BB60089; Mon,  9 Oct 2023 16:08:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <15f6b85f-b1ce-409a-a728-38a7223a7c6c@app.fastmail.com>
In-Reply-To: <202310091246.ED5A2AFB21@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
 <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
 <202310091246.ED5A2AFB21@keescook>
Date:   Mon, 09 Oct 2023 22:08:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, "Chun-Yi Lee" <jlee@suse.com>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org,
        "Iulia Tanasescu" <iulia.tanasescu@nxp.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 21:48, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
>> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
>> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
>> >> 
>> >> Sorry, I have to retract this, something went wrong on my
>> >> testing and I now see the same problem in some configs regardless
>> >> of whether the patch is applied or not.
>> >
>> > Perhaps turn them into macros instead?
>> 
>> I just tried that and still see the problem even with the macro,
>> so whatever gcc is doing must be a different issue. Maybe it
>> has correctly found a codepath that triggers this?
>> 
>> If you are able to help debug the issue better,
>> see these defconfigs for examples:
>> 
>> https://pastebin.com/raw/pC8Lnrn2
>> https://pastebin.com/raw/yb965unC
>
> This seems like a GCC bug. It is complaining about &hdev->bdaddr for
> some reason. This silences it:
>
> -	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> +	a = hdev->bdaddr;
> +	if (!bacmp(&a, &ev->bdaddr)) {

Right, I see this addresses all instances. I tried another thing
and this also seems to address them for me:

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3273,7 +3273,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
        /* Reject incoming connection from device with same BD ADDR against
         * CVE-2020-26555
         */
-       if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+       if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
                bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
                           &ev->bdaddr);
                hci_reject_conn(hdev, &ev->bdaddr);

and also this one does the trick:

--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -266,7 +266,7 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
 #endif
 
-#define bt_dev_name(hdev) ((hdev) ? (hdev)->name : "null")
+#define bt_dev_name(hdev) ((hdev)->name)
 
 #define bt_dev_info(hdev, fmt, ...)                            \
        BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)

So what is actually going on is that the bt_dev_dbg() introduces
the idea that hdev might be NULL because of the check.

     Arnd
