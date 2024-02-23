Return-Path: <linux-kernel+bounces-77811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F085860A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6C0B21C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2529125C0;
	Fri, 23 Feb 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZWRhS6Q"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC511C84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667559; cv=none; b=VETDPRAUpFO0fBGp1yOb9TuEMitkDjetYq5AhpEnd99C0gLUWJ8PMHeWRUBvbw2Isof1rQdWCsmsmplMdxfAB7f6inRHFm/Kd/4fqpLbg+M+QC0gcs5y1r0Jcj0STyyS+35LRZcp+QfyUeLtfGVyoodQsTCiDgx2E3pSuS5S26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667559; c=relaxed/simple;
	bh=KVeoM20/ZbgICC4EA8gBRPaJptQVERZGHgcDRMmhoLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5aYiKJyxweTraDE+KFTsc54HdtRtgWvzxea4XzP6nRWRI6UFNlqTuWbP8Rd/yTDsP4OAQ0c0C/bCczLOYM2CSYy9TK2HDGCwvYbOKiAoXYmQDNKZlboTYZCdQTSz52YQY0riTOwAZb+FFummxtwUL+PpJMt+GIGUQNZzgs2pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZWRhS6Q; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso531869276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708667557; x=1709272357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAzloSp374hRcWSwbOLOTG2YnTPULKXeKqlEaw+Xd/k=;
        b=yZWRhS6Q+q6y0n8YVeJ7akl9xAWKThMei6APPaQhR2YG3X5yWK1pKkJbnrMff/31hw
         twYsBoyEutr+izgZigzjzp2k4sPhrn5O8b2FvX47la6PoaGrXotHBYpFU81k9ROCLI4o
         mglcQzR9dIFbqv0r95iw6gwG9LpoThFWEmukwSmZxMsaSGu9NKAsT2bTMHW+pBWVkkFX
         3/2MMFjDk6QQdGNrJzUSwNJxoZODCl9RrqZ/qf0BjSOw0oe6B8NIwY2t9DKUZ9QtUPWg
         raX9AWa6ulr5a6R3MsYXHrzXjwVj3XM0ZMKt6Ger1No2mbA1OvgTVlG4CRvgxafc1EQ9
         BmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667557; x=1709272357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAzloSp374hRcWSwbOLOTG2YnTPULKXeKqlEaw+Xd/k=;
        b=ak2c69w5dSPzY0qpz9oOvhiyT/8OyjvtYVRExiamr+l9sJNv6DrY47Ily34CwwA6r3
         CWKxF3iF/W610upekjzPmjSnNWc1o0dBYpXx0r5YKvUHS5r8Q+avtmuesv5ATiV/Avdk
         LsoyYVDsIhjMHKaXAOUzHIucHx8pqY5R1BrdjHnvFxP0D3c/zpY2hiIkS6387wHV9w+1
         gyneAAwaGN4HJjWmt8FgDoJQzA0Jyt35bwm2TEW3gJvgkcG2fPLnLnNo8wPY9HWodzhz
         VXiP0USBgPSOGizgPI4Cs/EVXU4oiKwdDgpvODVQJGU6eGEma7+qF8pQzTKa02LiSQOI
         7Otg==
X-Forwarded-Encrypted: i=1; AJvYcCWVqzddMrndhoeTAeTrdkvxMe8Th9fXnjMtEQlhBXDYvy7Qagb03V4KB2UnE5+IvsnIK64IdkXghBEGZtz89N9ov4mT0yuV4mbNglKn
X-Gm-Message-State: AOJu0YysKjNsotVy35qJ6eSswTR8T5U7IzQ442GdlHXKqwjfLCPzUXj7
	YsJ8B+JS9OYVh7LZthSMbpUx8nn14DFL8qcnQ/80eC0DYaNVyveRzt6jwr9IiEoB96EGrfItByM
	PR+oZraIQow/25qmyzdra6ulQEWsVxbZWVmvr5w==
X-Google-Smtp-Source: AGHT+IEDuhpXAadkosR3FMGRRVOg1goeUcZpVtNmthigjJlek6IkW2X+xwqrA2q6rGwQkX3d9EdAnkN4bfyrxxTYc2Y=
X-Received: by 2002:a25:8d06:0:b0:dcb:fe58:a08b with SMTP id
 n6-20020a258d06000000b00dcbfe58a08bmr1168439ybl.15.1708667556906; Thu, 22 Feb
 2024 21:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-4-jthies@google.com>
In-Reply-To: <20240223010328.2826774-4-jthies@google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 07:52:25 +0200
Message-ID: <CAA8EJprn2jshq5S8HfKyyPK2A5P3zVNRvnagK+oqsfLnQgBGuQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 03:04, Jameson Thies <jthies@google.com> wrote:
>
> Register SOP and SOP' Discover Identity responses with the USB Type-C
> Connector Class as partner and cable identities, respectively. Discover
> Identity responses are requested from the PPM using the GET_PD_MESSAGE
> UCSI command.
>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Tested on v6.6 kernel. GET_PD_MESSAGE responses from the PPM populate
> partner and cable identity in sysfs.
> redrix-rev3 /sys/class/typec # ls port2-partner/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
> redrix-rev3 /sys/class/typec # ls port2-cable/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
>
>  drivers/usb/typec/ucsi/ucsi.c | 77 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h | 29 +++++++++++++
>  2 files changed, 106 insertions(+)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 15e82f5fab37..6d6443e61faa 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -646,6 +646,73 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
>         return ret;
>  }
>
> +static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient, struct usb_pd_identity *id)
> +{
> +       struct ucsi *ucsi = con->ucsi;
> +       struct ucsi_pd_message_disc_id resp = {};
> +       u64 command;
> +       int ret;
> +
> +       /*
> +        * Skip identity discovery and registration if UCSI version is less than
> +        * v2.0. Before v2.0 MESSAGE_IN is 16 bytes which cannot fit a complete
> +        * 24 byte identity response.

Please consider using two commands to retrieve the data. This will
allow you to support UCSI 1.x too.

> +        */
> +       if (ucsi->version < UCSI_VERSION_2_0)
> +               return -EPROTO;
> +
> +       command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) | UCSI_CONNECTOR_NUMBER(con->num);
> +       command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +       /* VDM Header + 6 VDOs (0x1c bytes) without an offset */
> +       command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
> +       command |= UCSI_GET_PD_MESSAGE_BYTES(0x1c);
> +       command |= UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +       ret = ucsi_send_command(ucsi, command, &resp, sizeof(resp));
> +       if (ret < 0) {
> +               dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       id->id_header = resp.id_header;
> +       id->cert_stat = resp.cert_stat;
> +       id->product = resp.product;
> +       id->vdo[0] = resp.vdo[0];
> +       id->vdo[1] = resp.vdo[1];
> +       id->vdo[2] = resp.vdo[2];
> +       return 0;
> +}
> +
> +static int ucsi_get_partner_identity(struct ucsi_connector *con)
> +{
> +       int ret;
> +
> +       ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP, &con->partner_identity);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = typec_partner_set_identity(con->partner);
> +       if (ret < 0)
> +               dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n", ret);
> +
> +       return ret;
> +}
> +
> +static int ucsi_get_cable_identity(struct ucsi_connector *con)
> +{
> +       int ret;
> +
> +       ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P, &con->cable_identity);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = typec_cable_set_identity(con->cable);
> +       if (ret < 0)
> +               dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n", ret);
> +
> +       return ret;
> +}
> +
>  static int ucsi_check_altmodes(struct ucsi_connector *con)
>  {
>         int ret, num_partner_am;
> @@ -754,6 +821,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
>                 break;
>         }
>
> +       desc.identity = &con->cable_identity;
>         desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.flags);
>         desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cable_prop.flags);
>
> @@ -776,6 +844,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
>
>         typec_unregister_cable(con->cable);
>         con->cable = NULL;
> +       memset(&con->cable_identity, 0, sizeof(con->cable_identity));

Nit: I'd probably call memset before setting con->cable to NULL.

>  }
>
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
> @@ -825,6 +894,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
>                 break;
>         }
>
> +       desc.identity = &con->partner_identity;
>         desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
>         desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
>
> @@ -854,6 +924,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>         ucsi_unregister_cable(con);
>         typec_unregister_partner(con->partner);
>         con->partner = NULL;
> +       memset(&con->partner_identity, 0, sizeof(con->partner_identity));

And the same here.

>  }
>
>  static void ucsi_partner_change(struct ucsi_connector *con)
> @@ -971,6 +1042,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>         if (ret < 0)
>                 return ret;
>
> +       ret = ucsi_get_cable_identity(con);
> +       if (ret < 0)
> +               return ret;
> +
>         return 0;
>  }
>
> @@ -1015,6 +1090,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>                         ucsi_register_partner(con);
>                         ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>                         ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +                       ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
>                         ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
>
>                         if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
> @@ -1414,6 +1490,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>                 ucsi_register_partner(con);
>                 ucsi_pwr_opmode_change(con);
>                 ucsi_port_psy_changed(con);
> +               ucsi_get_partner_identity(con);
>                 ucsi_check_cable(con);
>         }
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index f0aabef0b7c6..b89fae82e8ce 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -106,6 +106,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_GET_CABLE_PROPERTY                0x11
>  #define UCSI_GET_CONNECTOR_STATUS      0x12
>  #define UCSI_GET_ERROR_STATUS          0x13
> +#define UCSI_GET_PD_MESSAGE            0x15
>
>  #define UCSI_CONNECTOR_NUMBER(_num_)           ((u64)(_num_) << 16)
>  #define UCSI_COMMAND(_cmd_)                    ((_cmd_) & 0xff)
> @@ -159,6 +160,18 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_MAX_PDOS                          (4)
>  #define UCSI_GET_PDOS_SRC_PDOS                 ((u64)1 << 34)
>
> +/* GET_PD_MESSAGE command bits */
> +#define UCSI_GET_PD_MESSAGE_RECIPIENT(_r_)     ((u64)(_r_) << 23)
> +#define UCSI_GET_PD_MESSAGE_OFFSET(_r_)                ((u64)(_r_) << 26)
> +#define UCSI_GET_PD_MESSAGE_BYTES(_r_)         ((u64)(_r_) << 34)
> +#define UCSI_GET_PD_MESSAGE_TYPE(_r_)          ((u64)(_r_) << 42)
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SNK_CAP_EXT 0
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SRC_CAP_EXT 1
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_CAP     2
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_STAT    3
> +#define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY    4
> +#define   UCSI_GET_PD_MESSAGE_TYPE_REVISION    5
> +
>  /* -------------------------------------------------------------------------- */
>
>  /* Error information returned by PPM in response to GET_ERROR_STATUS command. */
> @@ -338,6 +351,18 @@ struct ucsi_connector_status {
>         ((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
>  } __packed;
>
> +/*
> + * Data structure filled by PPM in response to GET_PD_MESSAGE command with the
> + * Response Message Type set to Discover Identity Response.
> + */
> +struct ucsi_pd_message_disc_id {
> +       u32 vdm_header;
> +       u32 id_header;
> +       u32 cert_stat;
> +       u32 product;
> +       u32 vdo[3];
> +} __packed;
> +
>  /* -------------------------------------------------------------------------- */
>
>  struct ucsi_debugfs_entry {
> @@ -428,6 +453,10 @@ struct ucsi_connector {
>         struct usb_power_delivery_capabilities *partner_sink_caps;
>
>         struct usb_role_switch *usb_role_sw;
> +
> +       /* USB PD identity */
> +       struct usb_pd_identity partner_identity;
> +       struct usb_pd_identity cable_identity;
>  };
>
>  int ucsi_send_command(struct ucsi *ucsi, u64 command,
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


-- 
With best wishes
Dmitry

