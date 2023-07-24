Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159375F2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGXKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGXKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4115FE5;
        Mon, 24 Jul 2023 03:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FD561026;
        Mon, 24 Jul 2023 10:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1CCC433CB;
        Mon, 24 Jul 2023 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690193642;
        bh=HyTz6CKQLTCvi7h5fsEwc37nKq0GygklHRBNagV0woY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RStjl/pJendaad7xkjy31K6L0g364U1VDe22lwArLZ8+C10XaxRmi9cZoTeelrfaG
         7Jx5y0AE0mYe2sqLO24R3fW3jo5fPtpiVasynSQzVfpcktJ8yQI0EgsJOvAtDDyESb
         OI5iO10W1rPiTgSosyZs4XXVxbABVXcwFPQK8TvC/hrabXrccNngjtSlEh5oK2sI9a
         /+3qaDLkqZsKXU1v8+m9xoH9GjcUug6HWWRD4nkG5GuwYcmjQDSd00R8/h56ZtXJfs
         jE0DhbSkijVkJtnziwH0vQmfkvqyRWWszMocLqKJUzxMkiI6HbHN8LhKUg2ztRDNuO
         ADQtkUsaD0shA==
Date:   Mon, 24 Jul 2023 12:13:56 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     "sandeep.cs" <sandeep.cs@samsung.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        junwan.cho@samsung.com, jitender.s21@samsung.com,
        suhyun_.kim@samsung.com, ih0923.kim@samsung.com,
        gaudium.lee@samsung.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [HID Patchsets v1 1/2] HID: Add support for Samsung Bluetooth
 hid devices
Message-ID: <wzc65xxad2cvgq3zlqjoofp7r7yhrnwhwfzjqdhsezsvcehg6v@lj5l2xqd5i7q>
References: <20230724084752.371245-1-sandeep.cs@samsung.com>
 <CGME20230724084836epcas5p3c6044b8e4b7824c3d1b2e221aa531a00@epcas5p3.samsung.com>
 <20230724084752.371245-2-sandeep.cs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724084752.371245-2-sandeep.cs@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Jul 24 2023, sandeep.cs wrote:
> This patch add support for the Samsung hid devices like keyboard, action mouse and gamepad over the Bluetooth connection.
> 
> Bluetooth devices
> 
> Vendor 04e8 (Samsung)
> Device 7021 (Samsung Wireless Keyboard)
> Device a000 (Samsung Wireless GamePad)
> Device a004 (Samsung Wireless Action Mouse)
> Device a005 (Samsung Wireless BookCover)
> Device a006 (Samsung Wireless Universal Keyboard)
> Device a064 (Samsung Wireless HOGP Keyboard)
> 
> And also, special key processing on each Samsung Bluetooth devices.
> 
> The changes in this commit adhere to the kernel coding guidelines.
> 
> Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
> Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
> Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
> ---
>  drivers/hid/hid-ids.h     |   8 +
>  drivers/hid/hid-samsung.c | 412 ++++++++++++++++++++++++++++++++++++--

That's a huge patch. Way too big for me IMO.

Please refactor the series with:
1. hid_is_usb() check being moved
2. fix the checkpatch complains without adding new devices
3+ split the remaining changes, one per device so we can track which
   device needs what.

(1. and 2. can be done in any order)

Cheers,
Benjamin

>  2 files changed, 399 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8a310f8ff20f..35b2f50ba3c6 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1139,6 +1139,14 @@
>  #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
>  #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
>  
> +#define USB_VENDOR_ID_SAMSUNG_ELECTRONICS	0x04e8
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_BOOKCOVER	0xa005
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
> +#define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
> +
>  #define USB_VENDOR_ID_SEMICO			0x1a2c
>  #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
>  #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD2	0x0027
> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
> index cf5992e97094..33e963303d11 100644
> --- a/drivers/hid/hid-samsung.c
> +++ b/drivers/hid/hid-samsung.c
> @@ -67,20 +67,17 @@ static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		rdesc[178] = 0x08;
>  		rdesc[180] = 0x06;
>  		rdesc[182] = 0x42;
> -	} else
> -	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
> +	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
>  			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
>  		samsung_irda_dev_trace(hdev, 203);
>  		rdesc[193] = 0x1;
>  		rdesc[195] = 0xf;
> -	} else
> -	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
> +	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
>  			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
>  		samsung_irda_dev_trace(hdev, 135);
>  		rdesc[125] = 0x1;
>  		rdesc[127] = 0xe;
> -	} else
> -	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
> +	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
>  			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
>  		samsung_irda_dev_trace(hdev, 171);
>  		rdesc[161] = 0x1;
> @@ -107,17 +104,39 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
>  
>  	switch (usage->hid & HID_USAGE) {
>  	/* report 2 */
> -	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
> -	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
> -	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;
> -	case 0x197: samsung_kbd_mouse_map_key_clear(KEY_COMPUTER); break;
> -	case 0x22b: samsung_kbd_mouse_map_key_clear(KEY_SEARCH); break;
> -	case 0x22c: samsung_kbd_mouse_map_key_clear(KEY_WWW); break;
> -	case 0x22d: samsung_kbd_mouse_map_key_clear(KEY_BACK); break;
> -	case 0x22e: samsung_kbd_mouse_map_key_clear(KEY_FORWARD); break;
> -	case 0x22f: samsung_kbd_mouse_map_key_clear(KEY_FAVORITES); break;
> -	case 0x230: samsung_kbd_mouse_map_key_clear(KEY_REFRESH); break;
> -	case 0x231: samsung_kbd_mouse_map_key_clear(KEY_STOP); break;
> +	case 0x183:
> +		samsung_kbd_mouse_map_key_clear(KEY_MEDIA);
> +		break;
> +	case 0x195:
> +		samsung_kbd_mouse_map_key_clear(KEY_EMAIL);
> +		break;
> +	case 0x196:
> +		samsung_kbd_mouse_map_key_clear(KEY_CALC);
> +		break;
> +	case 0x197:
> +		samsung_kbd_mouse_map_key_clear(KEY_COMPUTER);
> +		break;
> +	case 0x22b:
> +		samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
> +		break;
> +	case 0x22c:
> +		samsung_kbd_mouse_map_key_clear(KEY_WWW);
> +		break;
> +	case 0x22d:
> +		samsung_kbd_mouse_map_key_clear(KEY_BACK);
> +		break;
> +	case 0x22e:
> +		samsung_kbd_mouse_map_key_clear(KEY_FORWARD);
> +		break;
> +	case 0x22f:
> +		samsung_kbd_mouse_map_key_clear(KEY_FAVORITES);
> +		break;
> +	case 0x230:
> +		samsung_kbd_mouse_map_key_clear(KEY_REFRESH);
> +		break;
> +	case 0x231:
> +		samsung_kbd_mouse_map_key_clear(KEY_STOP);
> +		break;
>  	default:
>  		return 0;
>  	}
> @@ -125,10 +144,342 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
>  	return 1;
>  }
>  
> +static int samsung_kbd_input_mapping(struct hid_device *hdev,
> +	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
> +	unsigned long **bit, int *max)
> +{
> +	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
> +			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
> +		return 0;
> +	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
> +		usage->hid & HID_USAGE);
> +	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
> +		set_bit(EV_REP, hi->input->evbit);
> +		switch (usage->hid & HID_USAGE) {
> +		/* Only for UK keyboard */
> +		/* key found */
> +#ifdef CONFIG_HID_KK_UPGRADE
> +		case 0x32:
> +			samsung_kbd_mouse_map_key_clear(KEY_KBDILLUMTOGGLE);
> +			break;
> +		case 0x64:
> +			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
> +			break;
> +#else
> +		case 0x32:
> +			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
> +			break;
> +		case 0x64:
> +			samsung_kbd_mouse_map_key_clear(KEY_102ND);
> +			break;
> +#endif
> +		/* Only for BR keyboard */
> +		case 0x87:
> +			samsung_kbd_mouse_map_key_clear(KEY_RO);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
> +		switch (usage->hid & HID_USAGE) {
> +		/* report 2 */
> +		/* MENU */
> +		case 0x040:
> +			samsung_kbd_mouse_map_key_clear(KEY_MENU);
> +			break;
> +		case 0x18a:
> +			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
> +			break;
> +		case 0x196:
> +			samsung_kbd_mouse_map_key_clear(KEY_WWW);
> +			break;
> +		case 0x19e:
> +			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
> +			break;
> +		case 0x221:
> +			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
> +			break;
> +		case 0x223:
> +			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
> +			break;
> +		/* Smtart Voice Key */
> +		case 0x300:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY13);
> +			break;
> +		/* RECENTAPPS */
> +		case 0x301:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
> +			break;
> +		/* APPLICATION */
> +		case 0x302:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
> +			break;
> +		/* Voice search */
> +		case 0x305:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
> +			break;
> +		/* QPANEL on/off */
> +		case 0x306:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
> +			break;
> +		/* SIP on/off */
> +		case 0x307:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
> +			break;
> +		/* LANG */
> +		case 0x308:
> +			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
> +			break;
> +		case 0x30a:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
> +			break;
> +		case 0x30b:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static int samsung_gamepad_input_mapping(struct hid_device *hdev,
> +	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
> +	unsigned long **bit, int *max)
> +{
> +	if (!(HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE) ||
> +			HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)))
> +		return 0;
> +	dbg_hid("samsung wireless gamepad input mapping event [0x%x], %ld, %ld, [0x%x]\n",
> +		usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0], usage->hid & HID_USAGE_PAGE);
> +	if (HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE)) {
> +		switch (usage->hid & HID_USAGE) {
> +		case 0x01:
> +			samsung_kbd_mouse_map_key_clear(BTN_A);
> +			break;
> +		case 0x02:
> +			samsung_kbd_mouse_map_key_clear(BTN_B);
> +			break;
> +		case 0x03:
> +			samsung_kbd_mouse_map_key_clear(BTN_C);
> +			break;
> +		case 0x04:
> +			samsung_kbd_mouse_map_key_clear(BTN_X);
> +			break;
> +		case 0x05:
> +			samsung_kbd_mouse_map_key_clear(BTN_Y);
> +			break;
> +		case 0x06:
> +			samsung_kbd_mouse_map_key_clear(BTN_Z);
> +			break;
> +		case 0x07:
> +			samsung_kbd_mouse_map_key_clear(BTN_TL);
> +			break;
> +		case 0x08:
> +			samsung_kbd_mouse_map_key_clear(BTN_TR);
> +			break;
> +		case 0x09:
> +			samsung_kbd_mouse_map_key_clear(BTN_TL2);
> +			break;
> +		case 0x0a:
> +			samsung_kbd_mouse_map_key_clear(BTN_TR2);
> +			break;
> +		case 0x0b:
> +			samsung_kbd_mouse_map_key_clear(BTN_SELECT);
> +			break;
> +		case 0x0c:
> +			samsung_kbd_mouse_map_key_clear(BTN_START);
> +			break;
> +		case 0x0d:
> +			samsung_kbd_mouse_map_key_clear(BTN_MODE);
> +			break;
> +		case 0x0e:
> +			samsung_kbd_mouse_map_key_clear(BTN_THUMBL);
> +			break;
> +		case 0x0f:
> +			samsung_kbd_mouse_map_key_clear(BTN_THUMBR);
> +			break;
> +		case 0x10:
> +			samsung_kbd_mouse_map_key_clear(0x13f);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
> +		switch (usage->hid & HID_USAGE) {
> +		case 0x040:
> +			samsung_kbd_mouse_map_key_clear(KEY_MENU);
> +			break;
> +		case 0x223:
> +			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
> +			break;
> +		case 0x224:
> +			samsung_kbd_mouse_map_key_clear(KEY_BACK);
> +			break;
> +		/* Screen Capture */
> +		case 0x303:
> +			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
> +	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
> +	unsigned long **bit, int *max)
> +{
> +	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
> +			usage->hid, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
> +			usage->hid & HID_USAGE_PAGE);
> +	if (((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER) && ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON))
> +		return 0;
> +	switch (usage->hid & HID_USAGE) {
> +	case 0x301:
> +		samsung_kbd_mouse_map_key_clear(254);
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 1;
> +}
> +static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
> +	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
> +	unsigned long **bit, int *max)
> +{
> +	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
> +			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
> +		return 0;
> +	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
> +		usage->hid & HID_USAGE);
> +	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
> +		set_bit(EV_REP, hi->input->evbit);
> +		switch (usage->hid & HID_USAGE) {
> +		/* Only for UK keyboard */
> +		/* key found */
> +#ifdef CONFIG_HID_KK_UPGRADE
> +		case 0x32:
> +			samsung_kbd_mouse_map_key_clear(KEY_KBDILLUMTOGGLE);
> +			break;
> +		case 0x64:
> +			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
> +			break;
> +#else
> +		case 0x32:
> +			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
> +			break;
> +		case 0x64:
> +			samsung_kbd_mouse_map_key_clear(KEY_102ND);
> +			break;
> +#endif
> +		/* Only for BR keyboard */
> +		case 0x87:
> +			samsung_kbd_mouse_map_key_clear(KEY_RO);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
> +		switch (usage->hid & HID_USAGE) {
> +		/* report 2 */
> +		/* MENU */
> +		case 0x040:
> +			samsung_kbd_mouse_map_key_clear(KEY_MENU);
> +			break;
> +		case 0x18a:
> +			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
> +			break;
> +		case 0x196:
> +			samsung_kbd_mouse_map_key_clear(KEY_WWW);
> +			break;
> +		case 0x19e:
> +			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
> +			break;
> +		case 0x221:
> +			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
> +			break;
> +		case 0x223:
> +			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
> +			break;
> +		/* RECENTAPPS */
> +		case 0x301:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
> +			break;
> +		/* APPLICATION */
> +		case 0x302:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
> +			break;
> +		/* Voice search */
> +		case 0x305:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
> +			break;
> +		/* QPANEL on/off */
> +		case 0x306:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
> +			break;
> +		/* SIP on/off */
> +		case 0x307:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
> +			break;
> +		/* LANG */
> +		case 0x308:
> +			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
> +			break;
> +		case 0x30a:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
> +			break;
> +		case 0x070:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
> +			break;
> +		case 0x30b:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
> +			break;
> +		case 0x06f:
> +			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
> +			break;
> +		/* S-Finder */
> +		case 0x304:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY7);
> +			break;
> +		/* Screen Capture */
> +		case 0x303:
> +			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
> +			break;
> +		/* Multi Window */
> +		case 0x309:
> +			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY9);
> +			break;
> +		/* HotKey App 1 */
> +		case 0x071:
> +			samsung_kbd_mouse_map_key_clear(0x2f5);
> +			break;
> +		/* HotKey App 2 */
> +		case 0x072:
> +			samsung_kbd_mouse_map_key_clear(0x2f6);
> +			break;
> +		/* HotKey App 3 */
> +		case 0x073:
> +			samsung_kbd_mouse_map_key_clear(0x2f7);
> +			break;
> +		/* Dex */
> +		case 0x06e:
> +			samsung_kbd_mouse_map_key_clear(0x2bd);
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
>  static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  	unsigned int *rsize)
>  {
> -	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product)
> +	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE)
>  		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
>  	return rdesc;
>  }
> @@ -139,10 +490,24 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  {
>  	int ret = 0;
>  
> -	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product)
> +	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE)
>  		ret = samsung_kbd_mouse_input_mapping(hdev,
>  			hi, field, usage, bit, max);
> -
> +	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
> +		ret = samsung_kbd_input_mapping(hdev,
> +			hi, field, usage, bit, max);
> +	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
> +		ret = samsung_gamepad_input_mapping(hdev,
> +			hi, field, usage, bit, max);
> +	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
> +		ret = samsung_actionmouse_input_mapping(hdev,
> +			hi, field, usage, bit, max);
> +	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD)
> +		ret = samsung_universal_kbd_input_mapping(hdev,
> +			hi, field, usage, bit, max);
> +	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD)
> +		ret = samsung_universal_kbd_input_mapping(hdev,
> +			hi, field, usage, bit, max);
>  	return ret;
>  }
>  
> @@ -161,7 +526,7 @@ static int samsung_probe(struct hid_device *hdev,
>  		goto err_free;
>  	}
>  
> -	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
> +	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
>  		if (hdev->rsize == 184) {
>  			/* disable hidinput, force hiddev */
>  			cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
> @@ -183,6 +548,11 @@ static int samsung_probe(struct hid_device *hdev,
>  static const struct hid_device_id samsung_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, samsung_devices);
> -- 
> 2.25.1
> 
