Return-Path: <linux-kernel+bounces-110188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1F885B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24B9B21860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76768615C;
	Thu, 21 Mar 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6LV5WN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462155792;
	Thu, 21 Mar 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033272; cv=none; b=MbPvBGcAtK4EvipYUWC3JT0/ziHPukT3UH59U2xf1MhVWmZWZ3ERFHfCVl/FdkO/G9djOZ0xEvFoynv5btR79C7ipuZC5YpegZEjQiLSwizzUURCsAdc9i+kNeTtWbCiqmgho/z+mw7EK8vJixsmTfxs0mI+fLGfDoaIcFR5/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033272; c=relaxed/simple;
	bh=PEJrHSKt1U+K2L5GVnfRCuafwN7gw0OYFsINbYiBTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHx4i6QuDYUBmTUYXVFIeDKTTCOtVERy8Ckj68iz1ipQ/aMaVwja5YljDTfgg+Iha1GqnIfnT6aHfuI9fp1jORNFkf/N5gJlLC3wPSlpDEmkZ3smcgnWEAdZoaN5WxnwaJ3tYwnh3X+4tdeqSfl5Mo8A6ni9h6VOn486dN+4K7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6LV5WN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223A7C433F1;
	Thu, 21 Mar 2024 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033271;
	bh=PEJrHSKt1U+K2L5GVnfRCuafwN7gw0OYFsINbYiBTdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6LV5WN3cJeKpxPr3PEudhZ0rutxUFjpiz3rzcP/5XF2mJaGCmyGDuWItvM5/n1iZ
	 COlgIKNmhcOb9DYaAS6ZdSy/HZ/CHws+xOsblsl48Vrd5RDmc+XfABK4KocwyhQA1C
	 dN64eFtIXZijfLOG6/6vHR2aTpyz3yHWeUVCEn/NikbQDND8CcmYNvkUnAykAAk26d
	 yBJ9zVEE/S2/2TS6E7/fYHA5t9wuOH4mec2abjoSpOXUZ+DiBCbcwTrtYsjIgnNB1x
	 yaKSy2LARjVFcd5pG6sxsynBawEy51576AMJONfeQRIsQ21FsySBxdYfyJB4CjKTzJ
	 QPwyEdJFtIBOA==
Date: Thu, 21 Mar 2024 16:01:06 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: uclogic: Store firmware name in params
Message-ID: <dadh7jtdpdf3iahcgxdaqadpc6k6gnaz6gatxycxpd4u2atl7a@2f4vzqwzt7n3>
References: <20240321144553.262409-1-jose.exposito89@gmail.com>
 <20240321144553.262409-2-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321144553.262409-2-jose.exposito89@gmail.com>


Hi José,

On Mar 21 2024, José Expósito wrote:
> A future patch will need to access the firmware name to expose it to
> userspace via sysfs.
> 
> Store it in `uclogic_params->fw_name`.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/hid-uclogic-params.c | 14 +++++++-------
>  drivers/hid/hid-uclogic-params.h |  5 +++++
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> index 9859dad36495..79ec3eb80f84 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -121,6 +121,7 @@ void uclogic_params_hid_dbg(const struct hid_device *hdev,
>  		params->invalid ? "true" : "false");
>  	hid_dbg(hdev, ".desc_ptr = %p\n", params->desc_ptr);
>  	hid_dbg(hdev, ".desc_size = %u\n", params->desc_size);
> +	hid_dbg(hdev, ".fw_name = %s\n", params->fw_name);
>  	hid_dbg(hdev, ".pen = {\n");
>  	uclogic_params_pen_hid_dbg(hdev, &params->pen);
>  	hid_dbg(hdev, "\t}\n");
> @@ -652,6 +653,7 @@ void uclogic_params_cleanup(struct uclogic_params *params)
>  	if (!params->invalid) {
>  		size_t i;
>  		kfree(params->desc_ptr);
> +		kfree(params->fw_name);
>  		uclogic_params_pen_cleanup(&params->pen);
>  		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++)
>  			uclogic_params_frame_cleanup(&params->frame_list[i]);
> @@ -837,7 +839,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>  	/* The resulting parameters (noop) */
>  	struct uclogic_params p = {0, };
>  	static const char transition_ver[] = "HUION_T153_160607";
> -	char *ver_ptr = NULL;
>  	const size_t ver_len = sizeof(transition_ver) + 1;
>  	__u8 *params_ptr = NULL;
>  	size_t params_len = 0;
> @@ -870,14 +871,14 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>  	}
>  
>  	/* Try to get firmware version */
> -	ver_ptr = kzalloc(ver_len, GFP_KERNEL);
> -	if (ver_ptr == NULL) {
> +	p.fw_name = kzalloc(ver_len, GFP_KERNEL);
> +	if (!p.fw_name) {
>  		rc = -ENOMEM;
>  		goto cleanup;
>  	}
> -	rc = usb_string(udev, 201, ver_ptr, ver_len);
> +	rc = usb_string(udev, 201, p.fw_name, ver_len);
>  	if (rc == -EPIPE) {
> -		*ver_ptr = '\0';
> +		*p.fw_name = '\0';
>  	} else if (rc < 0) {
>  		hid_err(hdev,
>  			"failed retrieving Huion firmware version: %d\n", rc);
> @@ -885,7 +886,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>  	}
>  
>  	/* If this is a transition firmware */
> -	if (strcmp(ver_ptr, transition_ver) == 0) {
> +	if (strcmp(p.fw_name, transition_ver) == 0) {
>  		hid_dbg(hdev,
>  			"transition firmware detected, not probing pen v2 parameters\n");
>  	} else {
> @@ -1028,7 +1029,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>  	rc = 0;
>  cleanup:
>  	kfree(params_ptr);
> -	kfree(ver_ptr);
>  	uclogic_params_cleanup(&p);
>  	return rc;
>  }
> diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
> index d6ffadb2f601..412c916770f5 100644
> --- a/drivers/hid/hid-uclogic-params.h
> +++ b/drivers/hid/hid-uclogic-params.h
> @@ -232,6 +232,11 @@ struct uclogic_params {
>  	 * List of event hooks.
>  	 */
>  	struct uclogic_raw_event_hook *event_hooks;
> +	/*
> +	 * Firmware name, exposed to userspace via sysfs as it is used to
> +	 * identify the tablet.
> +	 */
> +	char *fw_name;

I can't remember if this was on the table or not, but any reasons to not
use hid->uniq[64] field instead of a custom sysfs?
If there is already a value, we could just append the firmware version
with a colon (:) separator.

The main reason would be to not export a new sysfs specifically for this
driver, but it would also allow HID-BPF to have access to the value and
thus allow to detect if the device works with the given bpf program.

Cheers,
Benjamin

>  };
>  
>  /* Driver data */
> -- 
> 2.44.0
> 

