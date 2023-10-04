Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A77B81DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbjJDOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbjJDOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:11:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CEBF;
        Wed,  4 Oct 2023 07:11:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7741109bdeeso148974785a.2;
        Wed, 04 Oct 2023 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696428679; x=1697033479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksUh+jrzzPybnoiQtQr0hrHzGQz1wGgqWI8u8Q1EWwE=;
        b=FibIyqO5qxJDuwJNsNg3C1HZqN6UW9irFKi+YWOqeq/gnGgVjFm0AWCgbYj21RxA6Y
         HlUAjRE0vO3driSVmtluSL86j6rjFK8ZtkGmZ3kUYdpT/g+O2Sf8xtOoS9HHog2eqVBr
         6qhxI6Kbb2IA1SDbkoSLa4wSBmMja7nAE6QUwxgKSd5INj8R3Kh6NpMKvFOTRw/PDj47
         IpttbthxrSUaFu4uhOc3hxfg8QyszeH/82VAYwUn5BnCHs7W3RYvOD8pPSjGDsNwzBBU
         3RvTXZJYoDsOukTfTnQ7IzvteLbIbzEmEBDVz5eQTDLDqdMakCibS8y2k6E8iGWWrg5e
         0hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428679; x=1697033479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksUh+jrzzPybnoiQtQr0hrHzGQz1wGgqWI8u8Q1EWwE=;
        b=F6sF0fLR61cri8Rt3D//DcsFNcNUcF092q3rlAzNVrwdx6TxmveexT87d9kn6WO5dP
         KwALP1/PYC9j6rkyugHN81oGkigAiLbkyDo+tuv0v1/8DgH7apA7ijHz75zQXnW/RCbd
         +mmtgv38BwQEkrArx8m5Pr9N/w3l61CTDqUTkMO7ICqqRXFgUOJb+fP8a3jjnnmJD8n5
         yksFPCiDZOOvy6tzCTNL/D8XOBW4IYxxnrRujS3Khoe4NCPXofUGugKhPGHt4nr/6ttS
         zMhARxRTmNQ2glKAJu6SuLWPUxEykgdHb29+MAHnqDnfmd4RFgazoxCYeLYAT8W/Fgg2
         SDkg==
X-Gm-Message-State: AOJu0Yx8mrscBq9eow9WQtYkZ7qkW8uF57fhk3oRLarV9n3ous2hMSk+
        hiK5aPMxDRE9LqOrlM/C4q8=
X-Google-Smtp-Source: AGHT+IH/IAS+d9I4qWoXCuKpcuQ84RN9Tb4+vrGL/0GIxBtw8qst5tubQ93uWZKgmvywJp8KC+EXZA==
X-Received: by 2002:a05:620a:2911:b0:773:b62b:3474 with SMTP id m17-20020a05620a291100b00773b62b3474mr2532251qkp.63.1696428678933;
        Wed, 04 Oct 2023 07:11:18 -0700 (PDT)
Received: from penguin ([205.220.129.20])
        by smtp.gmail.com with ESMTPSA id op52-20020a05620a537400b0076d9e298928sm1286326qkn.66.2023.10.04.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:11:18 -0700 (PDT)
Date:   Wed, 4 Oct 2023 07:10:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     regressions@lists.linux.dev, benjamin.tissoires@redhat.com,
        linux@leemhuis.info, Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - fix fast_reconnect callback in ps2 mode
Message-ID: <ZR1yUFJ8a9Zt606N@penguin>
References: <20231004005729.3943515-1-jefferymiller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004005729.3943515-1-jefferymiller@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffery,

On Tue, Oct 03, 2023 at 07:57:24PM -0500, Jeffery Miller wrote:
> Make `elantech_setup_ps2` set a compatible fast_reconnect pointer
> when its ps2 mode is used.
> 
> When an SMBus connection is attempted and fails `psmouse_smbus_init`
> sets fast_reconnect to `psmouse_smbus_reconnect`.
> `psmouse_smbus_reconnect` expects `psmouse->private` to be
> `struct psmouse_smbus_dev` but `elantech_setup_ps2` replaces
> it with its private data. This was causing an issue on resume
> since psmouse_smbus_reconnect was being called while in ps2, not SMBus
> mode.
> 
> This was uncovered by commit 92e24e0e57f7 ("Input: psmouse - add delay when
> deactivating for SMBus mode")

Nice find, thank you.

> 
> Closes:
> Link:https://lore.kernel.org/all/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> 
> Signed-off-by: Jeffery Miller <jefferymiller@google.com>
> ---
> 
> The other callbacks set in psmouse_smbus_init are already replaced.
> Should fast_reconnect be set to `elantech_reconnect` instead?

No, doing PS/2 Elantech reinitialization is not a "fast" operation, as
it takes a while to communicate with/query the device, so we should not
be using elantech_reconnect() as a "fast" reconnect handler.

In fact, now that I think about it more, we should rework the original
patch that added the delay, so that we do not wait these 30 msec in the
"fast" reconnect handler. It turns out your original approach was
better, but we should not be using retries, but rather the existing
reset_delay_ms already defined in rmi platform data. I would appreciate
if you try the draft patch at the end of this email (to be applied after
reverting your original one adding the delay in psmouse-smbus.c).

> 
> 
>  drivers/input/mouse/elantech.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 2118b2075f43..4e38229404b4 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -2114,6 +2114,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
>  	psmouse->protocol_handler = elantech_process_byte;
>  	psmouse->disconnect = elantech_disconnect;
>  	psmouse->reconnect = elantech_reconnect;
> +	psmouse->fast_reconnect = NULL;

I think we need a similar change in synaptics.c as that one also can
fall back to PS/2 mode.

Thanks!

---

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..6ccc4a099b51 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1752,6 +1752,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 7059a2762aeb..b0b099b5528a 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -235,12 +235,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -253,11 +270,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -272,7 +288,6 @@ static int rmi_smb_probe(struct i2c_client *client)
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -311,18 +326,9 @@ static int rmi_smb_probe(struct i2c_client *client)
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 

-- 
Dmitry
