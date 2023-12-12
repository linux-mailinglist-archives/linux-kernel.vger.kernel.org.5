Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7581180F2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjLLQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjLLQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:33:40 -0500
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC7DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702398823; bh=PfzYYzAu0GcZMpn3lDDRxLehdkHTWolcz4K7BoULOl4=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=o1YuTYWdhdWnSH6lizKbRTdg4R27G/gYEA2oH22tu5Y6PpQSsccf0NUaukKbbXqDKbFjVF0jsn7j6Fxx3yFSzC0UrUTzaZqfhjsrypI4otctLR2CD5D10yIAHM1KJi9I95QLAqvTEaGB8xoy8/LyTdlktobjPWz+Y+uLeldVq7V3n32ac4UOt768VPvEd1GvOV3LvyI+qBBLkf+9/ush3FVheOylP6B1OefgNhqnLQePvcE6JdYuyw5Ibu8pvcg3npt0+HcnYcxlU8vsFsRs3s8aAX0LxFbM2uyEJPRd1xbwE4TScivJX3R6oGJTj1dJbQVhXlPkrRqen617WQQAKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702398823; bh=VZeZmwXcz2w/s7Y+30wYdaRolvHMVp35LANf9fVni3M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J/96CdG8gwbfKnLhAMgXtV8HFQLNq0Tp/kX9sREySuKlFny+2KCIqj/tGSvuTrKdn7a2s8F8HaSXfkIgQPWRWkHKMpMfqwIwrnIZFfVathPFcxBFqFpp+jx4biADTH5FwtDAVXOyHRgoQUhuvgHc1v+aABuYcDYL5cHtTDbZWsBbl76x5DqSsi0l8GNI8aDVXjVMsUPGFF37QK9IPJiHTk8Jcn0op6DFoezLTVvMNaYuH1ZOvqxU1bzIsXbS0sDYnv88SErAtf7UXq92rENm7CAtro/X22Nx1ULlSyNMyziACONNbG/7XX+CBBx67bguHWHClk/pACnPGaLi3F+Vkw==
X-YMail-OSG: GQfemjMVM1lHU9Sya1oZ3eUxSPN_FzZr.rp_yr0greAvxGJjDQ5Dv6ZHDaIwECD
 PCLxSJx0o3aih.mO64hT0GxtAGUTqVX.gA6J0mD5R4JqVdbZ_VkUaFmvW8Hvuxxjf8frs80dRS9o
 FGl2XanQZ1M4MVqqZhFKYjfOxBFEQbiny_DtwOQ.Dp0zt2mGHDp54OVsI0bPAFrHZppzLO63D.2V
 5al6F9Nyplv7ZTFWcuVHWqXioVdDz77FgVsvdMSVrLuLF8PSEC2mw6HMvLU6K8n7PiArorX3oNVn
 YyLgrQ14WepCFsVKP_djYyUTIcd8INmpW9cbwFABQIHOXIDXpv_WirvP4vWAWU2haTSo.29hIcws
 Zvlkq52qaSpe6xRPm0O1.tXgRw9Pu7cCP8qKmae7x3n4SKUwV2o0HHRTzBcJvtFX6l6xFdMC4mv3
 4LPkZ97B8mGrq7QSvsRDqmY4d.akKr20HW_ySUxK_Q9A.CpYlrlEY1eU2nHbCEJAbpowHd9nwVtN
 h00yaErl7_PzpcBeg7PK.YPAlE0sCfxj5ONuvQ56aUmytMEeUCeQYzOj_vQhxjIwwCTAtowy7FdS
 S1Q7OoAUb04r7KyMPPvLlS53tpX8onk1zK8o7CCCfRvQxta.d6L8I.PM4nyeHzgAkn5SLK9Ysy0O
 Sww4dYALRC7P1CIuCwHHdmidXBxbiAaB2XJuSB.Jz7m8WHCEVtEPxNnHXkF18QkDY_s_68e.VUsm
 N.7Z1vTg2oU7cSGN.ji.nckeTZa0jWkTpQ0VJTWSyuLQzT2z4zy0bR87RVgj26NRBRgWAyEpm8er
 LmzqL8VVD.Czg.n29Wb299Wty.F8yqfHjeWLouVtuFSNzoXnhqJ.bBE5BbBMFfS__AV3PDAE6ZPq
 i3CPgWjmVXc_wXuuCy_qIDH7lJzN7yKNLigbAx474lMdf7WjNdfUiW9hk9nSZwP.P7Naw3iZKn4h
 LEGmB1qVeb1kIii9BbygPLJsWp8GKV.istO8lNYRPV3eJbL7eiY2j3eJ3mlM25OjcKN93D1FZseK
 ektgZOPEKbr1V12pvSDFgXRF_f7DPb_O7hH5HwdtOQFbgYx_UKdfAQH7dz36kAm.NT9xPzCUjS0F
 cMIMEv45nxAZkPCvAsiif3Tq6h6txgr9zczDpg7ipj2Hs5RRtlyJ_Nf5naJ5W4cLGOUnQjqKO2Mb
 cJxjUgHpb6hAGPETx.UDAwb6x3UMQq_pwnGDcmR3Cc5wJEAtyPmtmoTATOAIbh_6OhDPGzW3Kfuo
 E2p0aqm.DewyQGnEPCUpc1jhqQtGik7CXsUiNKqMGEfNkqssPlnxiUu5R7B04etTv3TPlILyns.s
 4X6mFVd75a5Tzeq5H_vS0CFe37qUWDNWROkb70ZDC1AiuJknCvqsiQ8ypXkdGVSM7UfoAQfw5qgt
 NmN40_ppASoLAiRj7iyJHoxkW6_fulJCEXW3fuQgHplG2K2J13y5tEgA2czh1iyOuFC5MecqG3jY
 iGczR0LFMqufeTOwlN8EnsyYZJ.AVURasgt93MtphtOer1R7KTgWsnNjEX_CfA5cZ_1nyEQZG9fE
 E8IhaUpRUONY8xfwU9tEOAyAWSVdk3j0r0s9H.9936nvarTsYOwoB0Paq2tKQ2YATN6QC4Aq7NDj
 MBzK8ktqh7Xz3gWVhHfaACpRaV07_0WMt1qhcSMZNxzQpQsgi7e1bffg6VkpjQAM9vi5MndOtveX
 JQQ3jyAQ2wj1LmJNYU7CHzqhVwUGffPAkZZnc8FukMEWGKwOHX4xRu0sxchY8OeQKZvKjEIwQBge
 3Age0HPPiTZ4H57BBYGjfIxPSz0TiXuzHviDI09CDc.JE17eoLsEmgCCqx.RmkshmvFS7vIn_fpi
 sDXuDLs9lcNJ36CIBIayBGSQm4JkxCEsRyD8.72y3P9lD6cRqk9CXIoB9FXL7xKdX.Qucrd9muEU
 vD1Xo7O0tqJ_umnHTzZkvlQL7bQnO.QCcPFjHWqklmD8..Vj.Z1iKyldCJr2wiNcJqIx7qKSSKT2
 vtoXNRTC3CRk0wWMXp_fJwV5yChwdYGvvvg8LivztaYtdZ3zF0D9hYu8h8KgG_U2rQUIDNoSjXXK
 XE7rqj2w1OrEEqLvOm9.LfxX86t9QWQKDCZc_u0vEhVqDmLINmKa3RB9eSyYouGxIpdJFxxuD2SI
 r_QlX8nGCzrnQ4WwG8vjFUm8Z5zyuIg3qnPWZ1KyA7frAoXPFBJ3Z.hS1jsu2BwJM8BEv1eWiYrc
 0eCL7A6lE6MsgZOCUHTB28mLivPbAWTd8zQZzjkfR8xAqa18JmoaxLgC1tkCXwdAjf2XS5tk8KBm
 GtCnOiGlX8cE4RLQ1yosj
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 14f5b0a1-e886-4b05-b9e8-67de0727e527
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Dec 2023 16:33:43 +0000
Received: by hermes--production-gq1-64499dfdcc-pxg8l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 74da5172b15303642e3db225338ccf69;
          Tue, 12 Dec 2023 16:33:41 +0000 (UTC)
Message-ID: <c58da5f5-131f-425e-b008-260506d1bc0d@schaufler-ca.com>
Date:   Tue, 12 Dec 2023 08:33:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
Content-Language: en-US
To:     Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231212131712.1816324-5-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 5:17 AM, Maxime Coquelin wrote:
> This patch introduces a LSM hook for devices creation,
> destruction (ioctl()) and opening (open()) operations,
> checking the application is allowed to perform these
> operations for the Virtio device type.

My earlier comments on a vduse specific LSM hook still hold.
I would much prefer to see a device permissions hook(s) that
are useful for devices in general. Not just vduse devices.
I know that there are already some very special purpose LSM
hooks, but the experience with maintaining them is why I don't
want more of them. 

>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  MAINTAINERS                         |  1 +
>  drivers/vdpa/vdpa_user/vduse_dev.c  | 13 ++++++++++++
>  include/linux/lsm_hook_defs.h       |  2 ++
>  include/linux/security.h            |  6 ++++++
>  include/linux/vduse.h               | 14 +++++++++++++
>  security/security.c                 | 15 ++++++++++++++
>  security/selinux/hooks.c            | 32 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  8 files changed, 85 insertions(+)
>  create mode 100644 include/linux/vduse.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0fb0df07b43..4e83b14358d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23040,6 +23040,7 @@ F:	drivers/net/virtio_net.c
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> +F:	include/linux/vduse.h
>  F:	include/linux/virtio*.h
>  F:	include/linux/vringh.h
>  F:	include/uapi/linux/virtio_*.h
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index fa62825be378..59ab7eb62e20 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -8,6 +8,7 @@
>   *
>   */
>  
> +#include "linux/security.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cdev.h>
> @@ -30,6 +31,7 @@
>  #include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/vduse.h>
>  
>  #include "iova_domain.h"
>  
> @@ -1442,6 +1444,10 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
>  	if (dev->connected)
>  		goto unlock;
>  
> +	ret = -EPERM;
> +	if (security_vduse_perm_check(VDUSE_PERM_OPEN, dev->device_id))
> +		goto unlock;
> +
>  	ret = 0;
>  	dev->connected = true;
>  	file->private_data = dev;
> @@ -1664,6 +1670,9 @@ static int vduse_destroy_dev(char *name)
>  	if (!dev)
>  		return -EINVAL;
>  
> +	if (security_vduse_perm_check(VDUSE_PERM_DESTROY, dev->device_id))
> +		return -EPERM;
> +
>  	mutex_lock(&dev->lock);
>  	if (dev->vdev || dev->connected) {
>  		mutex_unlock(&dev->lock);
> @@ -1828,6 +1837,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	int ret;
>  	struct vduse_dev *dev;
>  
> +	ret = -EPERM;
> +	if (security_vduse_perm_check(VDUSE_PERM_CREATE, config->device_id))
> +		goto err;
> +
>  	ret = -EEXIST;
>  	if (vduse_find_dev(config->name))
>  		goto err;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ff217a5ce552..3930ab2ae974 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -419,3 +419,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>  LSM_HOOK(int, 0, uring_sqpoll, void)
>  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
>  #endif /* CONFIG_IO_URING */
> +
> +LSM_HOOK(int, 0, vduse_perm_check, enum vduse_op_perm op_perm, u32 device_id)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1d1df326c881..2a2054172394 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -32,6 +32,7 @@
>  #include <linux/string.h>
>  #include <linux/mm.h>
>  #include <linux/sockptr.h>
> +#include <linux/vduse.h>
>  
>  struct linux_binprm;
>  struct cred;
> @@ -484,6 +485,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>  int security_locked_down(enum lockdown_reason what);
> +int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -1395,6 +1397,10 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +static inline int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/include/linux/vduse.h b/include/linux/vduse.h
> new file mode 100644
> index 000000000000..7a20dcc43997
> --- /dev/null
> +++ b/include/linux/vduse.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VDUSE_H
> +#define _LINUX_VDUSE_H
> +
> +/*
> + * The permission required for a VDUSE device operation.
> + */
> +enum vduse_op_perm {
> +	VDUSE_PERM_CREATE,
> +	VDUSE_PERM_DESTROY,
> +	VDUSE_PERM_OPEN,
> +};
> +
> +#endif /* _LINUX_VDUSE_H */
> diff --git a/security/security.c b/security/security.c
> index dcb3e7014f9b..150abf85f97d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5337,3 +5337,18 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
>  	return call_int_hook(uring_cmd, 0, ioucmd);
>  }
>  #endif /* CONFIG_IO_URING */
> +
> +/**
> + * security_vduse_perm_check() - Check if a VDUSE device type operation is allowed
> + * @op_perm: the operation type
> + * @device_id: the Virtio device ID
> + *
> + * Check whether the Virtio device creation is allowed
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
> +{
> +	return call_int_hook(vduse_perm_check, 0, op_perm, device_id);
> +}
> +EXPORT_SYMBOL(security_vduse_perm_check);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index feda711c6b7b..18845e4f682f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -21,6 +21,8 @@
>   *  Copyright (C) 2016 Mellanox Technologies
>   */
>  
> +#include "av_permissions.h"
> +#include "linux/vduse.h"
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -92,6 +94,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/virtio_ids.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6950,6 +6953,34 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>  
> +static int selinux_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
> +{
> +	u32 requested_op, requested_type, sid = current_sid();
> +	int ret;
> +
> +	if (op_perm == VDUSE_PERM_CREATE)
> +		requested_op = VDUSE__CREATE;
> +	else if (op_perm == VDUSE__DESTROY)
> +		requested_op = VDUSE__DESTROY;
> +	else if (op_perm == VDUSE_PERM_OPEN)
> +		requested_op = VDUSE__OPEN;
> +	else
> +		return -EINVAL;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_op, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (device_id == VIRTIO_ID_NET)
> +		requested_type = VDUSE__NET;
> +	else if (device_id == VIRTIO_ID_BLOCK)
> +		requested_type = VDUSE__BLOCK;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_type, NULL);
> +}
> +
>  /*
>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>   * 1. any hooks that don't belong to (2.) or (3.) below,
> @@ -7243,6 +7274,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>  #endif
> +	LSM_HOOK_INIT(vduse_perm_check, selinux_vduse_perm_check),
>  };
>  
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..b0a358cbac1c 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
>  	  { "override_creds", "sqpoll", "cmd", NULL } },
>  	{ "user_namespace",
>  	  { "create", NULL } },
> +	{ "vduse",
> +	  { "create", "destroy", "open", "net", "block", NULL} },
>  	{ NULL }
>    };
>  
