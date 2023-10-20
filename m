Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFF7D0C73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbjJTJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjJTJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:58:37 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A010D66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:58:35 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581d4f9a2c5so344984eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697795914; x=1698400714; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f+gvat9CrHPoffTa5kopujCzvhVc8wtZggROVKd1nMk=;
        b=Wu85ZNC2c78OxFsWVNTJiCQqe4j0R2fh9nk21ccaL4hvXgLI5SviUjWhPXwUS4/Fyv
         +q1CPS3+d1g3yA3SlGmK7qk/6XMHGDr+IILODSlkKvM1o/ZlxlQaqgOe8+LuTK+T//55
         /5xvhuZ5ZPEjU2jv226iBrrhD6nR1ES+4fhKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795914; x=1698400714;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+gvat9CrHPoffTa5kopujCzvhVc8wtZggROVKd1nMk=;
        b=CRNlMOssRH9UQlzgalnvTJ96knzaLm6YeKfOF+8MPf75yyILaC7G0T8JMSzBdumqXX
         hIEGajSdg6d7Zyzr47keA1A01zyrkd1dhAouN1FVHq1zX2BoUHieUUcLvfUw0CQWDsnE
         p4uoSjyySQIFWLbSCal8Gon2qxyZ+LgvEO4+iF81BTQJHjdKGN9Wbjv+muT6ZVQ5yoCp
         9hX0Kl+0qYycHJ8J1JTCQgF22YNnKXn25RPljijQFZrL9X7XKKCSCOHwPMi1M+i3H9qB
         R1wBPU0Irom/GDyxw2bQXKqulPlV3P1mWLe6qArp5rzkT0Kc8luSkZ6SqymdzP2mfff9
         twjA==
X-Gm-Message-State: AOJu0YxOYJzJIAiXuYV27cH1qnleem0Z41v8NiyWHMBGEIMkVKpUswHE
        5oUcroj8xPAAN3D8V7//+UXwOA==
X-Google-Smtp-Source: AGHT+IG1rhwAAVMYRWzx4l8SBK63ETZ1qZ/qywHuWEWfxcBiYMz24Z/f3/5Z0yqH+39CcOK8ve/lag==
X-Received: by 2002:a05:6358:3995:b0:139:c75f:63eb with SMTP id b21-20020a056358399500b00139c75f63ebmr1316704rwe.21.1697795914172;
        Fri, 20 Oct 2023 02:58:34 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b006baa1cf561dsm1171606pfq.0.2023.10.20.02.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:58:32 -0700 (PDT)
Message-ID: <3e08f96d-9fc7-e806-70b3-8e6fc09f6123@broadcom.com>
Date:   Fri, 20 Oct 2023 11:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 3/5] wifi: brcmfmac: Add support for SCAN_V3
To:     Daniel Berlin <dberlin@dberlin.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
References: <cover.1697650207.git.dberlin@dberlin.org>
 <9bb36bcc0dbbbe6f991be30ec404b6e5197238ac.1697650207.git.dberlin@dberlin.org>
In-Reply-To: <9bb36bcc0dbbbe6f991be30ec404b6e5197238ac.1697650207.git.dberlin@dberlin.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006267b3060822eaf2"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006267b3060822eaf2
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This is essentially identical to SCAN_V2 with an extra field where we
> had a padding byte, so don't bother duplicating the entire structure.
> Just add the field and the logic to set the version properly.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 20 +++++++++++++------
>   .../broadcom/brcm80211/brcmfmac/feature.c     | 16 ++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/feature.h     |  1 +
>   .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 15 +++++++++++++-
>   4 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 7143ffe659f6..4cf728368892 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -1125,6 +1125,7 @@ static void brcmf_scan_params_v2_to_v1(struct brcmf_scan_params_v2_le *params_v2
>   }
>   
>   static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
> +			     struct brcmf_if *ifp,
>   			     struct brcmf_scan_params_v2_le *params_le,
>   			     struct cfg80211_scan_request *request)
>   {
> @@ -1141,8 +1142,13 @@ static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
>   
>   	length = BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
>   
> -	params_le->version = cpu_to_le16(BRCMF_SCAN_PARAMS_VERSION_V2);
> +	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V3))
> +		params_le->version = cpu_to_le16(BRCMF_SCAN_PARAMS_VERSION_V3);
> +	else
> +		params_le->version = cpu_to_le16(BRCMF_SCAN_PARAMS_VERSION_V2);
> +
>   	params_le->bss_type = DOT11_BSSTYPE_ANY;
> +	params_le->ssid_type = 0;
>   	params_le->scan_type = cpu_to_le32(BRCMF_SCANTYPE_ACTIVE);
>   	params_le->channel_num = 0;
>   	params_le->nprobes = cpu_to_le32(-1);
> @@ -1237,7 +1243,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
>   		/* Do a scan abort to stop the driver's scan engine */
>   		brcmf_dbg(SCAN, "ABORT scan in firmware\n");
>   
> -		brcmf_escan_prep(cfg, &params_v2_le, NULL);
> +		brcmf_escan_prep(cfg, ifp, &params_v2_le, NULL);
>   
>   		/* E-Scan (or anyother type) can be aborted by SCAN */
>   		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
> @@ -1497,11 +1503,13 @@ brcmf_run_escan(struct brcmf_cfg80211_info *cfg, struct brcmf_if *ifp,
>   		goto exit;
>   	}
>   	BUG_ON(params_size + sizeof("escan") >= BRCMF_DCMD_MEDLEN);
> -	brcmf_escan_prep(cfg, &params->params_v2_le, request);
> +	brcmf_escan_prep(cfg, ifp, &params->params_v2_le, request);
>   
> -	params->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION_V2);
> -
> -	if (!brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
> +	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V3)) {
> +		params->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION_V3);
> +	} else if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
> +		params->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION_V2);
> +	} else {
>   		struct brcmf_escan_params_le *params_v1;
>   
>   		params_size -= BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> index 6d10c9efbe93..c545d3b250e1 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> @@ -287,6 +287,7 @@ static int brcmf_feat_fwcap_debugfs_read(struct seq_file *seq, void *data)
>   void brcmf_feat_attach(struct brcmf_pub *drvr)
>   {
>   	struct brcmf_if *ifp = brcmf_get_ifp(drvr, 0);
> +	struct brcmf_wl_scan_version_le scan_ver;
>   	struct brcmf_pno_macaddr_le pfn_mac;
>   	struct brcmf_gscan_config gscan_cfg;
>   	u32 wowl_cap;
> @@ -337,7 +338,20 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
>   		ifp->drvr->feat_flags |= BIT(BRCMF_FEAT_SCAN_RANDOM_MAC);
>   
>   	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_FWSUP, "sup_wpa");
> -	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_SCAN_V2, "scan_ver");
> +
> +	err = brcmf_fil_iovar_data_get(ifp, "scan_ver", &scan_ver, sizeof(scan_ver));
> +	if (!err) {
> +		int ver = le16_to_cpu(scan_ver.scan_ver_major);
> +
> +		if (ver == 2) {
> +			ifp->drvr->feat_flags |= BIT(BRCMF_FEAT_SCAN_V2);
> +		} else if (ver == 3) {
> +			/* We consider SCAN_V3 a subtype of SCAN_V2 since the
> +			 * structure is essentially the same.
> +			 */
> +			ifp->drvr->feat_flags |= BIT(BRCMF_FEAT_SCAN_V2) | BIT(BRCMF_FEAT_SCAN_V3);
> +		}
> +	}
>   
>   	if (drvr->settings->feature_disable) {
>   		brcmf_dbg(INFO, "Features: 0x%02x, disable: 0x%02x\n",
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> index 7f4f0b3e4a7b..3317e80c398a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> @@ -56,6 +56,7 @@
>   	BRCMF_FEAT_DEF(FWAUTH) \
>   	BRCMF_FEAT_DEF(DUMP_OBSS) \
>   	BRCMF_FEAT_DEF(SCAN_V2) \
> +	BRCMF_FEAT_DEF(SCAN_V3) \
>   	BRCMF_FEAT_DEF(PMKID_V2) \
>   	BRCMF_FEAT_DEF(PMKID_V3)

Having API versioning marked as feature does not feel right. Will 
probably come up with different mechanism for that.

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index 9d248ba1c0b2..1077e6f1d61a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> @@ -52,6 +52,7 @@
>   
>   /* version of brcmf_scan_params structure */
>   #define BRCMF_SCAN_PARAMS_VERSION_V2	2
> +#define BRCMF_SCAN_PARAMS_VERSION_V3	3
>   
>   /* masks for channel and ssid count */
>   #define BRCMF_SCAN_PARAMS_COUNT_MASK	0x0000ffff
> @@ -72,6 +73,7 @@
>   #define DOT11_BSSTYPE_ANY		2
>   #define BRCMF_ESCAN_REQ_VERSION		1
>   #define BRCMF_ESCAN_REQ_VERSION_V2	2
> +#define BRCMF_ESCAN_REQ_VERSION_V3	3
>   
>   #define BRCMF_MAXRATES_IN_SET		16	/* max # of rates in rateset */
>   
> @@ -414,7 +416,7 @@ struct brcmf_scan_params_v2_le {
>   	s8 bss_type;		/* default: any,
>   				 * DOT11_BSSTYPE_ANY/INFRASTRUCTURE/INDEPENDENT
>   				 */
> -	u8 pad;
> +	u8 ssid_type;		/* v3 only */
>   	__le32 scan_type;	/* flags, 0 use default */
>   	__le32 nprobes;		/* -1 use default, number of probes per channel */
>   	__le32 active_time;	/* -1 use default, dwell time per channel for
> @@ -833,6 +835,17 @@ struct brcmf_wlc_version_le {
>   	__le16 wlc_ver_minor;
>   };
>   
> +/**
> + * struct brcmf_wl_scan_version_le - scan interface version
> + */
> +struct brcmf_wl_scan_version_le {
> +	__le16 version;
> +	__le16 length;
> +	__le16 scan_ver_major;
> +};
> +
> +#define BRCMF_WL_SCAN_VERSION_VERSION 1
> +
>   /**
>    * struct brcmf_assoclist_le - request assoc list.
>    *


--0000000000006267b3060822eaf2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdwYJKoZIhvcNAQcCoIIQaDCCEGQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3OMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVYwggQ+oAMCAQICDE79bW6SMzVJMuOi1zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTQzMjNaFw0yNTA5MTAxMTQzMjNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEFyZW5kIFZhbiBTcHJpZWwxKzApBgkqhkiG
9w0BCQEWHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDxOB8Yu89pZLsG9Ic8ZY3uGibuv+NRsij+E70OMJQIwugrByyNq5xgH0BI22vJ
LT7VKCB6YJC88ewEFfYi3EKW/sn6RL16ImUM40beDmQ12WBquJRoxVNyoByNalmTOBNYR95ZQZJw
1nrzaoJtK0XIsv0dNCUcLlAc+jHkngD+I0ptVuWoMO1BcJexqJf5iX2M1CdC8PXTh9g4FIQnG2mc
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBJGq34sf9DfZhozcbD
x3gZ6/IgyiCoNgmd7aWGufMHrjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEwMjAwOTU4MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA6BMp/cfrOfuFNH0UZAvnOJsP1s55s/Nuhm6z
hjk5IidcAdpY9DzuUPMHZrnQyEaMN6nr2WR7oBZH/4uTmuN4E4wTcs789wV/jyIV5oBlRr0jEllM
wk4zS4AkG4iMQdJtmKs7ovRD/SoL3C8d4KWTMAaZxA+O1PgRVmN3X3tsYXEF6IThn/xpN1raJLsw
amb+2d3cuIO2GFmOAgvi+Tx6mj0yKB+Am1FCLAP8dt8tD8v1ux0BIwtrysZUDcy2K0USVP7MZ/HW
5uk5CaqObiXaYi6VytPVXtgdVI38+NGnVubLQRJGfKZ36oFkEGvSFFDjQZ2ouEHmmf7rve4AVQg0
ng==
--0000000000006267b3060822eaf2--
