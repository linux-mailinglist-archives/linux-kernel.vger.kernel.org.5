Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1837AB9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjIVTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjIVTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B2792
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695409347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHmkUSGxPrlIaYw9c6LuofpUkFimHOYZxkrmsFQmPvA=;
        b=JWfNJ3F9ydr/t6dCUrIDJXkg/KPcsvjZjTUBbsfhrb/0A508Rr4R02Ehy/kGDrmflgDDGs
        SypS41lbRL2YTroMa7Ymg1aqDiwR8IkkpAnx8mQxft89jIki6aQo0r2aDG6qkygrK3PfjV
        ScJ3pj2PEph/0Ao+SQ2SQyqIKUQnwaE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-OgyQh32UOeKCXyLXLgAQ-w-1; Fri, 22 Sep 2023 15:02:25 -0400
X-MC-Unique: OgyQh32UOeKCXyLXLgAQ-w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-417f94d6938so13932411cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409345; x=1696014145;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHmkUSGxPrlIaYw9c6LuofpUkFimHOYZxkrmsFQmPvA=;
        b=evQr4tetWl9cFGpNqGvHTHIEZp4l5NGriKwoGNsc61jg8dweVf/4mZHaCAx51nfn0b
         IdYsG1fzyEUnEv8mttXF4NG3x+9VqEPC4CwsQGMqZwywblzBUxkP8p7rPzxgaA/fsmpN
         oCKEvegvCBk4BQf/n+En/18Qm/kChIPRSbR1RGCnxEoRQ/c82vCq3ZbD3ByweseFwFy6
         1p/xsv1ReJL3SulTIjNsAVoabQ6CxT26EL6KsxCFWaiALnFsytVdLwIJ8WGgYvaLxD3O
         32LX2zhcOFFadZjKGhtWvu0KTIztITVIs785T9niV3zt5j8g33T26L3zLaEWqQx/cCch
         bLkA==
X-Gm-Message-State: AOJu0Yy0kNrGiOmZK3nLBD4B2cykmXgGrHUbeQ9nwAUUncRtakw3ioVn
        ZvXSlD1hbwAGkzgVtrLXKUHQDhKVivbk69v38xnPsCLMDu1XoIEUi68tHiDD3xeXuK/vANf3iDk
        2mKYhavVaiTcCH0VCHKVB45xy
X-Received: by 2002:a05:622a:3d4:b0:403:b4da:6e53 with SMTP id k20-20020a05622a03d400b00403b4da6e53mr341911qtx.44.1695409345031;
        Fri, 22 Sep 2023 12:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbV18P7x/XW/4COmPd32jER+IQbq9RzSsi1dKKADvcR9PdhwtZSP7a81sT/HUxE8JXfLwHug==
X-Received: by 2002:a05:622a:3d4:b0:403:b4da:6e53 with SMTP id k20-20020a05622a03d400b00403b4da6e53mr341894qtx.44.1695409344797;
        Fri, 22 Sep 2023 12:02:24 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id x7-20020ac87ec7000000b0041096c33d02sm639550qtj.17.2023.09.22.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:02:24 -0700 (PDT)
Message-ID: <19ce2cd9abfd3bdf3ea91f9bceb43206e4740c2e.camel@redhat.com>
Subject: Re: [PATCH v1] drm/dp/mst: fix missing modeset unlock for MST port
 detect
From:   Lyude Paul <lyude@redhat.com>
To:     Ramya SR <quic_rsr@quicinc.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jeff Layton <jlayton@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Sep 2023 15:02:23 -0400
In-Reply-To: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
References: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oh! wow thank you for catching this:

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will go and push this to drm-misc-next in just a moment

On Fri, 2023-09-15 at 10:24 +0530, Ramya SR wrote:
> Modeset mutex unlock is missing in drm_dp_mst_detect_port function.
> This will lead to deadlock if calling the function multiple times in
> an atomic operation, for example, getting imultiple MST ports status
> for a DP MST bonding scenario.
>=20
> Signed-off-by: Ramya SR <quic_rsr@quicinc.com>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index ed96cfc..d6512c4 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4154,7 +4154,7 @@ drm_dp_mst_detect_port(struct drm_connector *connec=
tor,
> =20
>  	ret =3D drm_modeset_lock(&mgr->base.lock, ctx);
>  	if (ret)
> -		goto out;
> +		goto fail;
> =20
>  	ret =3D connector_status_disconnected;
> =20
> @@ -4181,6 +4181,8 @@ drm_dp_mst_detect_port(struct drm_connector *connec=
tor,
>  		break;
>  	}
>  out:
> +	drm_modeset_unlock(&mgr->base.lock);
> +fail:
>  	drm_dp_mst_topology_put_port(port);
>  	return ret;
>  }

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

