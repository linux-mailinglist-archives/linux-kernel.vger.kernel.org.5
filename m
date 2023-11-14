Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832ED7EB3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjKNPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:43:06 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83658FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:43:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-778a47bc09aso375735385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699976582; x=1700581382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXqvXp/Ul/Lfa/+vwJ63ergxm+v5cZYCyZMl2UyoqH8=;
        b=drvIVAoYcOJ4SYNgXefXXvIg7Rh+yh+cvL0EmOwDfVOTQlx1PfAB2EKgnj5VHwb7NS
         wCCWQhHlnUouvZThH9mLJHbAnnovRguyIZFqnMZQpgQuekzlOPcrm98+hm3O2WhX3aZu
         JvieoKqqvBgCuxlkvkNZEVd4IO8vfrd37IELRWWb/mMXPgW6G0na7ewPTaqz37Cq4XIl
         DRbhNxPEg8iXlRv83KtCS4bbWUU7T0EsIEruIfSZWy5tKd421fwINLMam96Tp9FjTTOh
         7ow12gzBQuqt3bC6tydcURFexnyqT6SCvSVlcMq+dWyJedGAD85v+UwTQ1PUAcJH/J7l
         QDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976582; x=1700581382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXqvXp/Ul/Lfa/+vwJ63ergxm+v5cZYCyZMl2UyoqH8=;
        b=I0eDOiBkqkYFzlvZdc2y2fYhV/xUkAyDnSgJIVvJU6NTxdHzkP+AthWNzkOfsZDS4J
         wItIRw8VMJxFUKBuRb2hw+V0T/WO7IPHUoxo9KqczPjtU62iMstP9LthX7bn/Wikc4Vu
         sDdPudAojiQpfcwlObjhTuVf3VXdT7BcHPaxZCQJ6RtiwPVuTbTiZULx2W8UIjWs1716
         +VCNj+5S/IEKRaHpnMraomUMi6aiSQrxba460UFcZQc2QNld3X9BnZKvEKX81TGKtM4Q
         Ebeek07fDxVFx1NUPpxYo3p/hFUAzNuYwblqHEmHji5JTOFaJfG+vAuy5zWXdF/Cq7Zk
         LDXQ==
X-Gm-Message-State: AOJu0YxjbP3IBUXgwvjOB1rdjKumbVz9+ipgo2Y7NVBVPr24sk8SIBhb
        uAY+TOjZGyrLA+B8ajX+i6MXdsN0uW5XVzZ9EkvabQ==
X-Google-Smtp-Source: AGHT+IE9qqSzBR+Yfr4UoTy6dzXMXAMK3DGOnV30TFMMiS0YOjvfvEyAkzNi5rq6NM4xD+eSP1fheUr0EB1BryZzLOU=
X-Received: by 2002:ad4:5110:0:b0:672:24bd:3e3f with SMTP id
 g16-20020ad45110000000b0067224bd3e3fmr170699qvp.31.1699976582471; Tue, 14 Nov
 2023 07:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20231102073056.174480-1-sumit.garg@linaro.org>
In-Reply-To: <20231102073056.174480-1-sumit.garg@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 14 Nov 2023 16:42:51 +0100
Message-ID: <CAHUa44FoiOinGHyB=P4EL+iMNA3KiLBzfCUw=wGpJuFzo_PMOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] tee: optee: Fixes for supplicant dependent enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, jan.kiszka@siemens.com,
        arnd@linaro.org, ardb@kernel.org, jerome.forissier@linaro.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 8:31=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
>
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
>
> Fix this by adding an attribute for supplicant dependent devices so that
> the user-space service can detect and detach supplicant devices before
> closing the supplicant:
>
> $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" &=
& -f "$dev/driver/unbind" ]]; \
>       then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
> While at it use the global system workqueue for OP-TEE bus scanning work
> rather than our own custom one.
>
> Changes in v4:
> - Changing the device name would be an ABI break, rather switch to
>   additional device attribute: "need_supplicant" to distinguish for ABI
>   compatibility.
> - Dropped tested-by for patch #1, I would encourage folks to retest
>   this.
>
> Changes in v3:
>
> - Split patch into 2 separate ones, one for supplicant fix and other for
>   the workqueue.
>
> Changes in v2:
>
> - Use device names to separate out tee-supplicant dependent devices via
>   this patch.
> - Since user-space service is aware about tee-supplicant lifespan, so
>   allow the user-space service to unbind tee-supplicant dependent
>   devices before killing the supplicant. Following command has to be
>   added to the tee-supplicant service file.
>
>   $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" =3D=3D *"optee-ta-=
supp-"* ]]; \
>         then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
> Sumit Garg (2):
>   tee: optee: Fix supplicant based device enumeration
>   tee: optee: Remove redundant custom workqueue
>
>  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
>  drivers/tee/optee/core.c                        | 13 ++-----------
>  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
>  drivers/tee/optee/optee_private.h               |  2 --
>  4 files changed, 26 insertions(+), 15 deletions(-)
>
> --
> 2.34.1
>

I'm picking up this.

Thanks,
Jens
