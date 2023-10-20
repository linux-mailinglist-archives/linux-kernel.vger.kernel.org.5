Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A537D1906
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJTWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJTWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:21:15 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5FD65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697840467; bh=p5Ya4nQfP4ifyGho3UkOYgxekcgP/9YKKFLv1oZ8qng=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=bWT7ZZu/1eiKD4PasbEgUVdODFLvbIrV7xrhADlses/4QLL9OZXTYZxYxZQyTfCchRgodoMzjx4Oub4vJgjvHxtRtJZDY0iGNMN4TC7L6Mrq+gL+rYqMszhmn6lDkdQC0kDAbgxjV+H11Ycn2TrQyf6ccSoyh0wVg/BJsm2RqwJfI2Ib6AIM+veZmyOlHmnpZHdAIwIrz3umNwd3YWU+6e4B3/ZRTG7PjdKGZGzW6EgQE0U0KnIOEiHjYICUV8Qt3OHHQyZL40qA+efKutSh6s9cEecMTpooSOdYWQXrIC+5IDM5BXKhDFU7kjr7inr1wejRGcVpt826D+dgHTfmxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697840467; bh=8MtTex5GJIpD3E7WVaBSSDHMtiW6ALaH5p8gBN2vuOZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=msrMB27HpL1LspCG+3v+D4AzbZX1n1GzlAltNUTetPC5l77idtWfoxtYXna1EWpkRorpbY2rO0g4n6cfrTVD5yqfwV/6Juhksmy9wZhMX4loLpUBEeU6wa4MIBwjVh+7fz2jZINIY5K0Z2YmshCh5m7XGdfbuHMB8pwMx9X34piS3/WOlrUhXrZHcryVgR3pGPcouKKnqNDvwpnsRJBzJpvSylty6WioOQslZXQGBrX2vA8p0Qm3tuCrsqo8np+yOrkXFeT29Wt2DPcE+R874Ty4XY20Zv4sNuLK1mOXFXy02sI7EdLsMayamZyyTRrYLPtgKzz1qybFGwMk55mJGw==
X-YMail-OSG: YarBMxEVM1nnNTlUgKLKtiVIeBxydFxKLCYlDCSe5cYMhMPwime6PlKpk0LVIkH
 BsggpzfxxsmpyN2t7ihGUJqure73Hw6tblMmEO2ENoqZMBOXLouLqwFTtJkAOyGmownLi43DeuU7
 FBfZwFJ3j2Df.V32Ewr4DZ0X_96dtrgL_T4hHMfX.TVSA4zNXmwaRo9ERyL.5E4KPph9H1DghERr
 uYOCh08ruI47rhNbYgUKD5WIjt4eIiP03IRGvUqyiCdN8hXrvGio8DB8hJ3yu.n9RCKv.es39k2x
 _kGIk0x5LkpEVvLFd1xJIjzqQxdwdJZwaO0ZR6EEH8YRCN2X8WLqf5dZQX8ZXmwbIJnFjg8pk3P8
 qQ1y6uaNnoYYOYSsQKJm7f2Eubj533dYaxTl9VHVPDvpQ0oJBJYwrmNykMeZw4_q1tuBIc4lE4Z7
 bIoxyXoQZ8X9Y4E9qJ3gRgWwlXHhA5jkBQy1Z8hq.3wgubeUyY1zf9tKmt0CnsJoHzBKukNTVr.q
 AjGzeOCOthYuHIw20G9zt1DB0iLBC8DgqmA8oYfItZwk8Zzu8qAMy1MZh8Knv_AHXgR4a67Xr_SP
 Wjvkq.K.EhUGpv17NTpQonXSaDLvC1MMVczuqSnWevBkkFN8s_8fWbbCi0CIBlUHDMwEaufyLLzT
 x0UEZu8ceRs0QCDKYzT8xv1pW_p2olRQdX.fk5kGa7CUhcjReOjcos8_LFvONhn_sDVApg8cndA0
 t2_xFopuJvjYSTFhEs4pVYu2WNiqYOwoL8_FPzcNNHNU9TOjCh.qphdscDZLdAYrBqxnKL7W0ZbH
 VUWYmDHmhPXkf.vVhcV_PeYdKiKHSH2eMpLsGJvVi6hkMbD8FtL8TN3XAZ9IJxQTqCta2xbDz.1B
 aXMxsILHKCQe6rQ8Kz.PpplynW8LOBz2yVyJZUXSEYQzt.iVFAm46gyuGyOvHwhsrpckvv_EbQO0
 AgQkWbp4EFlftgc8DOP.sZhU7yxvJDupbXPrmUdgRa4wCtPq6Ob9cC7vtkks2.JQG1HrygtFdayE
 cs03zArlcKaQCZBIHiHj29kQsRsM7PeJCzuJembonxUkW1Eb2TV69JGj1wohNwf6g8aS7IXmz2li
 OT1nqgyklPwGswdU660oVG2Xxe_Ex1RaE3UPWSPXA4xLqT6Xz6ilzycmbh14x2Cyx0VoeOO3vH_A
 Q8W7jeZ5Uy3k1wQ7pzHOiOzU9_cT1_euvu3RokPUT5rJGcCthC2csokASmuWyLtXzUuEuoJolj5A
 0.6jjhHgTJ9BPiWIh_iOSX0eLxx0rzi6f8BfD8BUsKA7olHwUYOZD4zMzWP7oL.OWvuZNPtqHORh
 QKgdI2qSmRxR_dlfjccgcg3Iw4h1RizvherriBpDJPra_0QaOXbTGcczqWq0FpzDPhMVXn7ujADE
 MqA87QhYzSTMZEl8fVh5qs0jtj8oKcTg4hXqeMrxtDnsEp2tcgGOd6z_318r1wep.5CyzrpBZz3m
 ZVHBqei3SrlHS5dPZQoKgSOCbeTMrJybx8AGg0dgoeKDm1BmvJNQ4KovpFhNL8ZzKVAemtLlrNcf
 7EKGkDQk3DePBF6ZryC8TSk2tjclpvCQCjiIbn3LuLv.TNpQobXS9h6QYOXmyb.ZBg7XfkbZGdhN
 V8XVxO_An0DQ5JPVNfrRU3XmTqXIm8qZcgUciUfd.wikcuoJTLapTuAQn5FDv0rIDD7cvHGzVfdT
 E1383cjF4Dms0qkcxT.6sxKMD8Fcvm9eDM_QPARUngtU_Z7X7Lvg_3YWmwtfa_uxs0t2vEtGsGTt
 IDAuzK0ldlXLPwfpGSmRm8OwhF10R9yoX4oPWpBqLXmgq6gL8mqEux5vS5k.DaVIEte1xXIMrxVJ
 _B7LsbY_56mdRZ47e5GX7odZZ_DNulnwRY0VjRQZjZues15psU_FXzFl8.Tac_hSXJ1_8kZmBtN2
 foZirzdyR3QM5.RnVO1F1shIXRn9p5FKymYTZNBZuMbPAYdCM9jC.XGZfM08HYn9Unh50xjOYMzK
 CELkSlsFJ9lJlsK1gjq6FeAlLMwL62d8wXBfI4aJ7tpwePOR.iIST2Ysr_0fUEFIO_bKm0detp6c
 0TjSKgDAP98LYPoF4sy2bWuQfEMFYDYGT58xuU32FAFHbPdZ61W3JeUh468MVzc8glh8q6C_gN8N
 dju6d8utWvvYPgC1bkk1pbobDPXlSEYp5WgENj2uVU10Z7p.JmdtuRSyAQ6wb4_7kDkKrcBmJy61
 62MVVCYtuLZX5t70B3Swc370Sd_Zihqe98A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 90484e65-0c03-4116-a6b9-bf75bf163d4d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 22:21:07 +0000
Received: by hermes--production-ne1-68668bc7f7-ktd8n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a37d43f2d4f3d4c4c17192a890253287;
          Fri, 20 Oct 2023 22:21:01 +0000 (UTC)
Message-ID: <c8f189e6-c79b-429a-ab36-2193bb68e3e9@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 15:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Content-Language: en-US
To:     Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
> This patch introduces LSM hooks for devices creation,
> destruction and opening operations, checking the
> application is allowed to perform these operations for
> the Virtio device type.

Why do you think that there needs to be a special LSM check for virtio
devices? What can't existing device attributes be used?

>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
>  include/linux/lsm_hook_defs.h       |  4 +++
>  include/linux/security.h            | 15 ++++++++
>  security/security.c                 | 42 ++++++++++++++++++++++
>  security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  6 files changed, 130 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 0243dee9cf0e..ca64eac11ddb 100644
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
> @@ -1443,6 +1444,10 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
>  	if (dev->connected)
>  		goto unlock;
>  
> +	ret = -EPERM;
> +	if (security_vduse_dev_open(dev->device_id))
> +		goto unlock;
> +
>  	ret = 0;
>  	dev->connected = true;
>  	file->private_data = dev;
> @@ -1655,6 +1660,9 @@ static int vduse_destroy_dev(char *name)
>  	if (!dev)
>  		return -EINVAL;
>  
> +	if (security_vduse_dev_destroy(dev->device_id))
> +		return -EPERM;
> +
>  	mutex_lock(&dev->lock);
>  	if (dev->vdev || dev->connected) {
>  		mutex_unlock(&dev->lock);
> @@ -1819,6 +1827,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	int ret;
>  	struct vduse_dev *dev;
>  
> +	ret = -EPERM;
> +	if (security_vduse_dev_create(config->device_id))
> +		goto err;
> +
>  	ret = -EEXIST;
>  	if (vduse_find_dev(config->name))
>  		goto err;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ac962c4cb44b..0b3999ab3264 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -419,3 +419,7 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>  LSM_HOOK(int, 0, uring_sqpoll, void)
>  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
>  #endif /* CONFIG_IO_URING */
> +
> +LSM_HOOK(int, 0, vduse_dev_create, u32 device_id)
> +LSM_HOOK(int, 0, vduse_dev_destroy, u32 device_id)
> +LSM_HOOK(int, 0, vduse_dev_open, u32 device_id)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f16eecde00b..a650c500f841 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -484,6 +484,9 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>  int security_locked_down(enum lockdown_reason what);
> +int security_vduse_dev_create(u32 device_id);
> +int security_vduse_dev_destroy(u32 device_id);
> +int security_vduse_dev_open(u32 device_id);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -1395,6 +1398,18 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +static inline int security_vduse_dev_create(u32 device_id)
> +{
> +	return 0;
> +}
> +static inline int security_vduse_dev_destroy(u32 device_id)
> +{
> +	return 0;
> +}
> +static inline int security_vduse_dev_open(u32 device_id)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/security.c b/security/security.c
> index 23b129d482a7..8d7d4d2eca0b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5337,3 +5337,45 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
>  	return call_int_hook(uring_cmd, 0, ioucmd);
>  }
>  #endif /* CONFIG_IO_URING */
> +
> +/**
> + * security_vduse_dev_create() - Check if a VDUSE device type creation is allowed
> + * @device_id: the Virtio device ID
> + *
> + * Check whether the Virtio device creation is allowed
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_vduse_dev_create(u32 device_id)
> +{
> +	return call_int_hook(vduse_dev_create, 0, device_id);
> +}
> +EXPORT_SYMBOL(security_vduse_dev_create);
> +
> +/**
> + * security_vduse_dev_destroy() - Check if a VDUSE device type destruction is allowed
> + * @device_id: the Virtio device ID
> + *
> + * Check whether the Virtio device destruction is allowed
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_vduse_dev_destroy(u32 device_id)
> +{
> +	return call_int_hook(vduse_dev_destroy, 0, device_id);
> +}
> +EXPORT_SYMBOL(security_vduse_dev_destroy);
> +
> +/**
> + * security_vduse_dev_open() - Check if a VDUSE device type opening is allowed
> + * @device_id: the Virtio device ID
> + *
> + * Check whether the Virtio device opening is allowed
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_vduse_dev_open(u32 device_id)
> +{
> +	return call_int_hook(vduse_dev_open, 0, device_id);
> +}
> +EXPORT_SYMBOL(security_vduse_dev_open);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..65d9262a37f7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2016 Mellanox Technologies
>   */
>  
> +#include "av_permissions.h"
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -92,6 +93,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/virtio_ids.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>  
> +static int vduse_check_device_type(u32 sid, u32 device_id)
> +{
> +	u32 requested;
> +
> +	if (device_id == VIRTIO_ID_NET)
> +		requested = VDUSE__NET;
> +	else if (device_id == VIRTIO_ID_BLOCK)
> +		requested = VDUSE__BLOCK;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> +}
> +
> +static int selinux_vduse_dev_create(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
> +static int selinux_vduse_dev_destroy(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVDESTROY, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
> +static int selinux_vduse_dev_open(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVOPEN, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
>  /*
>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>   * 1. any hooks that don't belong to (2.) or (3.) below,
> @@ -7243,6 +7295,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>  #endif
> +	LSM_HOOK_INIT(vduse_dev_create, selinux_vduse_dev_create),
> +	LSM_HOOK_INIT(vduse_dev_destroy, selinux_vduse_dev_destroy),
> +	LSM_HOOK_INIT(vduse_dev_open, selinux_vduse_dev_open),
>  };
>  
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..d3dc37fb03d4 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
>  	  { "override_creds", "sqpoll", "cmd", NULL } },
>  	{ "user_namespace",
>  	  { "create", NULL } },
> +	{ "vduse",
> +	  { "devcreate", "devdestroy", "devopen", "net", "block", NULL} },
>  	{ NULL }
>    };
>  
