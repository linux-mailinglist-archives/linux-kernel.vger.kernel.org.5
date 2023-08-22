Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D06784ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHVTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHVTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:48:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74088CCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:48:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-410a0af4a3cso11138851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1692733724; x=1693338524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZwMs73L9GPVFSghvQPsoUG7Sx2i2yQItRQfIWeacjM=;
        b=W4HoxWopD2hBY9n4p0llTM7KwBtYD0rVDad64IK2YljBCvh4ZZFnTulTjp6622taN7
         UNwEj09gBSs/yYKco/7Jq4VBxCgzy/zo/cOses7N6NgkgEhOASkJGL7LtZ1PR5Tjnh0f
         FFqQTS/gKgWZOiNjVbb79jLhsGXNSEJXb+8hUkh4Yj53HZ4hagLJjiuYRCSZKNtOLXKs
         FaHnM1BpxnSo0gCgxmbYh2Dpa7/tj+e9m8C1FPt8us7d84VMnUtUmab8ptkDJMOghqQo
         3bSd2fGUKQcqXhZEuYhEDhJ8QnH3blWU/lcAZzBs3ttjhoQO4RxDkM77PfYZQDmpKZRX
         f3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733724; x=1693338524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZwMs73L9GPVFSghvQPsoUG7Sx2i2yQItRQfIWeacjM=;
        b=d9LwLt68fkBl28pqnn/A/DEN9IC/Oh4QQVwSOJVqoB+ofupa/RC/KtihNbEjRHqtLy
         VAXfmsuD8Q22WjX8RRcFVeCNmOM51vsAT1wk7pc+Z+BdEC9KSUdqmwDxzAIvlkrKi6YV
         782GG44Q9W4tFM46FtmC/2yv2L9gD3WHqHy/TjQP6VT/pWaOKTClgPnhcU0Um7UVOyun
         KP1nTlIQYAEL0vZJQO/Lf7vhpXbjWmjtlwOCOlN1jpA2rUpKL6BaFXQyYEZ+ua1v1dTT
         oDQd/jSv/gtUNH9C8K9/zAxnsJ2cm/ewecfDpOIDnx2NM3OiAO9G+VNQb7gfGMc4KwtA
         Dpbw==
X-Gm-Message-State: AOJu0YzuV7f8LtIxdQ4tlGJeR/LClGAqal13sshSYgW7OzLWk5ZeL7uj
        zGetZUp5izvg/TVFXZoHzf/3r2MIbGiqkuGtt0IP/Q==
X-Google-Smtp-Source: AGHT+IGv0rYv5UfhFHx3uwlvRxfChSfhPyqbQZebTtcNl4f6ati86eWvrGHA3H+L3EKNx3W5kYdnSw==
X-Received: by 2002:a05:622a:10e:b0:40f:e493:534d with SMTP id u14-20020a05622a010e00b0040fe493534dmr15230040qtw.43.1692733724575;
        Tue, 22 Aug 2023 12:48:44 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id c2-20020ae9e202000000b0076daaccb7f7sm1364829qkc.135.2023.08.22.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:48:44 -0700 (PDT)
Message-ID: <7106092378907b360b75f5ffc1c5ecdeeba2d5b4.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: handle firmware debug message
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 22 Aug 2023 15:48:43 -0400
In-Reply-To: <20230822055207.31575-1-ming.qian@nxp.com>
References: <20230822055207.31575-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 22 ao=C3=BBt 2023 =C3=A0 13:52 +0800, Ming Qian a =C3=A9crit=C2=A0=
:
> decoder firmware may notify host some debug message,
> it can help analyze the state of the firmware in case of error
>=20
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vpu_defs.h    | 1 +
>  drivers/media/platform/amphion/vpu_helpers.c | 1 +
>  drivers/media/platform/amphion/vpu_malone.c  | 1 +
>  drivers/media/platform/amphion/vpu_msgs.c    | 9 +++++++++
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/pl=
atform/amphion/vpu_defs.h
> index 667637eedb5d..7320852668d6 100644
> --- a/drivers/media/platform/amphion/vpu_defs.h
> +++ b/drivers/media/platform/amphion/vpu_defs.h
> @@ -71,6 +71,7 @@ enum {
>  	VPU_MSG_ID_TIMESTAMP_INFO,
>  	VPU_MSG_ID_FIRMWARE_XCPT,
>  	VPU_MSG_ID_PIC_SKIPPED,
> +	VPU_MSG_ID_DBG_MSG,
>  };
> =20
>  enum VPU_ENC_MEMORY_RESOURSE {
> diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media=
/platform/amphion/vpu_helpers.c
> index af3b336e5dc3..d12310af9ebc 100644
> --- a/drivers/media/platform/amphion/vpu_helpers.c
> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> @@ -489,6 +489,7 @@ const char *vpu_id_name(u32 id)
>  	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
>  	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
>  	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
> +	case VPU_MSG_ID_DBG_MSG: return "debug msg";
>  	}
>  	return "<unknown>";
>  }
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/=
platform/amphion/vpu_malone.c
> index f771661980c0..d3425de7bccd 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -745,6 +745,7 @@ static struct vpu_pair malone_msgs[] =3D {
>  	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
>  	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
>  	{VPU_MSG_ID_PIC_SKIPPED, VID_API_EVENT_PIC_SKIPPED},
> +	{VPU_MSG_ID_DBG_MSG, VID_API_EVENT_DBG_MSG_DEC},
>  };
> =20
>  static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
> diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/pl=
atform/amphion/vpu_msgs.c
> index d0ead051f7d1..999efeaebfd5 100644
> --- a/drivers/media/platform/amphion/vpu_msgs.c
> +++ b/drivers/media/platform/amphion/vpu_msgs.c
> @@ -180,6 +180,14 @@ static void vpu_session_handle_pic_skipped(struct vp=
u_inst *inst, struct vpu_rpc
>  	vpu_inst_unlock(inst);
>  }
> =20
> +static void vpu_session_handle_dbg_msg(struct vpu_inst *inst, struct vpu=
_rpc_event *pkt)
> +{
> +	char *str =3D (char *)pkt->data;
> +
> +	if (strlen(str))
> +		dev_info(inst->dev, "instance %d firmware dbg msg : %s\n", inst->id, s=
tr);

I'm always a bit worried when a string is assumed nul-terminated and it com=
es
from a third party software (firmware). Perhaps we force it to terminate
somewhere already ? With this being verified (or corrected):

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> +}
> +
>  static struct vpu_msg_handler handlers[] =3D {
>  	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
>  	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
> @@ -196,6 +204,7 @@ static struct vpu_msg_handler handlers[] =3D {
>  	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
>  	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
>  	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
> +	{VPU_MSG_ID_DBG_MSG, vpu_session_handle_dbg_msg},
>  };
> =20
>  static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_=
event *msg)

