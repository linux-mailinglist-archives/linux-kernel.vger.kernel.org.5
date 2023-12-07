Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5A80876A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379193AbjLGMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjLGMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:12:43 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849E1AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:12:49 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d400779f16so4637507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951168; x=1702555968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nl7VzXYUVLpuywJ0ghnOgpBSVbJk3MSKILZ8n2HQ/Y=;
        b=S/mftodZiG4i4zFf1I5snXr76QX5fPvJ2UQLo9CYYm+rFwg+OIFKUmVvJHg0XYYTo0
         E16xkwZSgw0OdlnzXja4emaegK0lX/a8YvAj1FQp7arjpneT9Rav7GXlS7T5LETuSWS3
         5F19Hu5gxKqVYb1soc1K05uYEOF0l/4sHB6rp9AqJj4kdMk0vQuJsuIjkrevWXPqAokB
         geGYuTxwTX5RabpoUmswPvykiJgnux+tzYp79DNoRirvrbURpDrHtPD9JBqGaj5E7Bwq
         /+kg4x6Palc6uhgKGDNh8flhGikWEcEGOF1vTdpYi1DrmkCmpO/t7Gn9Eu5gRvkKGgQo
         MHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951168; x=1702555968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nl7VzXYUVLpuywJ0ghnOgpBSVbJk3MSKILZ8n2HQ/Y=;
        b=gJ83noSqHx4PF7cydC2pmEI0hYQy+Ibmz3UlYNlM5O7tSbCPbEXC+NARvNoNCU/THK
         +BQRKzs3bCHRiG+8Dap6rt2cog8msCRo5+FjewHFg6Qo4u+kDSQhNofv+iBUn7VhcpfE
         WB8ijWF07a4XfQ/A9VuT0k3dKIJCZDsnt4iDfgCHoSCpFj4MyoLkH/QN1Co9cFkDXnki
         /C0dvPXCDyuWhqSsf8kh8Qmb0/09ojMgUwYjoONQISwolkiekp9so6Xv5kX+1HlkFdlS
         SwsPzBktD9ujx1f3xH4ED+lJY7DkUiFasyC1DlkZcu3vIZXCLin3edxdLIbIhPuUObRO
         5l7w==
X-Gm-Message-State: AOJu0YxxDvCV9PSC48fb+do+o0aCcyMjfTwBMh6DbdrUBb2TXeFHNpyY
        JgTIHMAdncHVFyqGdif9FiaVOxHXx7oPdRbxy7n4fA==
X-Google-Smtp-Source: AGHT+IGBQEt+6GpTODFbSFDlARHWKMqOvTNDHhmGHjyt06ChJHobnZLbJNE5ZT57jwuIGHkEkLgeHxLiKcSb32XnRQM=
X-Received: by 2002:a81:5293:0:b0:5d7:1940:3ef6 with SMTP id
 g141-20020a815293000000b005d719403ef6mr1945230ywb.39.1701951168367; Thu, 07
 Dec 2023 04:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20231206123828.587065-1-arnd@kernel.org> <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
 <CAA8EJprV3O24V0+MnPK1OdQZQ_7F2aMfN1Um13eH9ux4J+ucMw@mail.gmail.com>
 <ZXGzJlv9C3Z9lMeI@kuha.fi.intel.com> <c1df6dc4-ad3f-41ba-b024-1b432dac7af1@app.fastmail.com>
In-Reply-To: <c1df6dc4-ad3f-41ba-b024-1b432dac7af1@app.fastmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 14:12:37 +0200
Message-ID: <CAA8EJpp+ikpFZ1BL4PZJG_kK3n_u3mTTGZjd8A+=20gPm_SOyA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 14:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 7, 2023, at 12:57, Heikki Krogerus wrote:
> > On Thu, Dec 07, 2023 at 01:55:06PM +0200, Dmitry Baryshkov wrote:
>
> > Okay, so this probable should also be
> >
> >         select DRM_AUX_BRIDGE if DRM_BRIDGE and OF
> >
> > No?
>
> I think that fails if CONFIG_OF is disabled and
> CONFIG_DRM_AUX_BRIDGE, since drm_aux_bridge_register()
> will still be called from a built-in driver in that
> case but can't be linked against.

If DRM_AUX_BRIDGE is not enabled, then the stubs from
include/drm/bridge/aux-bridge will be used instead.

-- 
With best wishes
Dmitry
