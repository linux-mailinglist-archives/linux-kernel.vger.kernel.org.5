Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4F80FA95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377904AbjLLWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLLWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:55:35 -0500
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841498
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702421739; bh=UyvNy/1r7rKshBkXFGtwCWlk0Hq4SWkz0HZPRlMSG2g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QQnwWaO8gTdjDwIBh9Gslbm5SNC+pUsqtzGBtJFsgtTcHfZmOCQtJeyhmisXlrVCGJ3DvTKjQsRUbbvAq0IV4iejurvxD760a/3uA69KOHYCPC3HNeD4nDIHo4h1KquJ/valMko9Ya+/Ry5ENCG9bPWs9nA2iK1cjtA/OEgAHBgHpTGA4LMg8Ua+HG11dGeSXsuQodj4v03U7gROLzNAVQYsta4vTyoZZIOeKyoSedS2J4+CwR+wIsFKu0jcRUZo87vmWZ9LlPKyZpdkpqnlUms+NvsHP33G/WybBhmYoLSnOEO4cKNJGnHs4FCECdUVjRhKQdwjWWTwUGhojFeoSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702421739; bh=QKVjAmdal/b3W99XCqH5xDUTKf9snk38fsEDnGje/5Y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AdPXxj7VMd39lRl11aRO+DFWwQRpHeomlR2H/CYBuHPxv6Ar/R9lAguN/74XL+O+UWI34IQ3c3nZLP0BP3uWp9ffJESzA71TBdnMG+w3OJjOQTliU4e+8v9VbeEFLGnoIl7hpAUHwDGGItd8DrwgQ8zd2hJ/Geo/F95KMyjj8TQ++AQRI1Ha1uWy9jNvivbjqNPqtZCHjGQt/YNfgEdTLEoZkagzc8e+kwqtcjcaomaCurAmKCAAK4pnRFA3LgYsWunNUXxbuF8rfmVv7Fm6iH9YTopRu1uv+cBgnxabN3NWxa475iAivb48EZa+PXd1u9bGYr6SPZcYX2j1jcSuow==
X-YMail-OSG: BrJmdSEVM1ll_DS2dIlDHLvHCo0H3W5whJBSlX.zKariIaX6jRqpUcaMLQ1Frnj
 BmRH.DxlqfLfuDQmCiY5lP5BxDOHxXoY.Wj0wrtag65dNf7iJjOXufrjOWxCvZxtZZHgZ98raVh6
 nRn3PjA6ZTyAXaoVgDQnMn2ob5Z46J2RfKx6fq2b2R4u34bKLT0lYPRC5_952dLbpwuHGG7ndPU2
 R2FX.a8YjV7MtiYfqqf1ugx0Qa2vMBwd9KTA6TdDSHBtNpvgoiHREsO0ylnRLbMjjRz50sjLN5mI
 HJlBpnBOvNI8NLZBFU56Upvyvb2ruJZLbdZNgIMMNeDXTcz01PIdRpY5v3stFIoff9qcpIFimcg_
 0nkqCgfK0TCzuWuIuodk3fWJ7E_bymQ93_l4o_k40vsS27Gvt16eTeOdPK7OQvYUvW5ToJfcff4v
 b42X8tUP.j0Zu8.RBZz_e.4U.lf5cVvqusb9b_YLOsLuGd0JgVbYMpSUwdq9yvB4ez5iliiJuRL0
 d5EHn10vD8PaT8VBGFBb.nuklDsgv4vtzNDAEnlTicAtG71EhJgfnAjQ0axV3xH1dxf7iYmIgbXH
 J_FnnRNQPMJypbrpAknmWxvPQAmdXSgDwxCDLHA8JUHe3oyEG.ChYTMNuXXUTIfUuUiayrD5y8YO
 VifzZAO8dq0LLMvn7JgaJTaBDHaipxZk46OEyMqjNmtl2WgjkmfvSg6eYGU.eAGfvQHxM8wrOvyl
 XxI4FV7Es0AX4CHofkJuIfCB6mvPhdBKrrKDysTbL8YSLj8_bUgIjxDOyC2dzR7J8IX7iuSAOrSY
 ww7xO2cGjAGQPgtKIuveQ3STDdNH3eSNp0q.0x._LB7wiRfF.uWEvwZfprzgHvcpJb3T7KHITKby
 akWc6o6pT7MC7333NnP8bIaMuilm5_o65dabWEX_y6LtiLaIiSFLDJ4mgSnwGu17MFim0f3GyAYn
 sCqW32OTfGiu3bJI3m2QvOnD9YP.yK2Hg61V1rTpjaJEVmcxO3UfY9VHSfm6mUcGs6YA8oQoKq.w
 OsQOC3V4oelhBNc6S3lgqkgqCZLVROEkez7SUzsqJ31hsExoqZcMXLfFE2uDC_xuw_soRZ4WGj6v
 EqW6ZKDaRHtN9cruULUpeIt8cWld801U84MCpX8bfkfE24iABQ.mFp3noGVozR4NjEo2b3i1E59d
 Ra_8zlhfEqNM0.MhC62xxHeX7xLn1FswWvTGPGcG2dwU1W7i6A7XE5o9Vs5FkO0eow44Rn00oK0n
 CdTmfQyCbucLblQlQdVYmMW9rANCFRZKrOXNFEgkdPkftaqxWp8h2MuqR1ujZFLLdjUceueQJAjF
 3.u7gXDpSgVksb4DaujhZ7WQ1flgaGzyMY.yma7J7S1xEEuOONdtTBVnIWLheSIAzW2qgCsb74KQ
 pU2jBsdb4zznnbN3ecOqqiIOnzDLyUthP3xIubFEiobCVlYtY6zI9xqezbzifst9u62W4Z.BCoC8
 OuwSRDf3UPv2RTctxp.k8KrgSSGApbQ791NmiRxTTIqehWAS3lI99RL4c_M_epZ75hPpnLDzTZDC
 SyOsoN8C4KQWpj3n8lJymgPu5M0Er6oE_GT9IwPnBTCxCq38mXtOcRotbstCcuiLA24ORjZOR.DY
 I4ejr_J5ATAaWODUnkmSQIbnrUay78Omk91JRBsfW8hBfvtuvZ05SzXIx8w0UHjoD0UCnJrArVU2
 MdIGbCJGf9QyeQBNv5hY3rxh5D72_i1iH0kqd1g7FHvCFODW.UkKfDn1Z9Xo1qweuaRs6g1DD5c6
 P7GfLUPW3Q20jepJUvP9I3VeDiEHDOJ3tWshyzRU9wIiGyUUInRVX0YOwzGcTrz06BNLNVZLu.wg
 w._dRMjRanEbeA_mHEPlM3H02tCe4W1ts47MdjPUqw7n4nb38W6704CHpWG0Jh116hz373pWXL10
 kheJjIQf9NykxvgXq_iWOU17TLv4SaWCR87dHqFCZS8iZe6Y.vR0qM5T9uAKpB.ywvPB7BUkuf7M
 ZPLlsRUir3soWqwnyRXlKKDCcMPX_oK4SEVaZnsyH4S_GwXPmr3JAxC_u0tbEkeYo8e9uoa9sThr
 CqAJZ_qykz1NybhcD0KF3.pl5AVj6qYJECY4VcxXcEhJiHzYHz2NP3WezHjtCG99LLOKw29VReGd
 6v3M9AJT_.mwMRnSmGPw4UMafJ1gEJVRezoXr5CX_JAkz9eVoX3UyZCxaQp3nb8XN8CObrTLE5i.
 R0kzagfieVrlpGs5E0nVkGelbETPrscraCxWm7NBo41NQKS2tAh0rlX9e1aAbiIPbsMbha9DEF1r
 YiTKtcR0hAvo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 37c829e1-9f20-4ed1-86a1-d10dc92b524a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Dec 2023 22:55:39 +0000
Received: by hermes--production-gq1-64499dfdcc-fxj72 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7fc3c2d3c0f3eb597f2f21d521e36336;
          Tue, 12 Dec 2023 22:55:34 +0000 (UTC)
Message-ID: <f7bd9ef6-cfa1-4b7e-a9f9-0b6015ac394f@schaufler-ca.com>
Date:   Tue, 12 Dec 2023 14:55:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, xieyongji@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com>
 <c58da5f5-131f-425e-b008-260506d1bc0d@schaufler-ca.com>
 <20231212124518-mutt-send-email-mst@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231212124518-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 9:59 AM, Michael S. Tsirkin wrote:
> On Tue, Dec 12, 2023 at 08:33:39AM -0800, Casey Schaufler wrote:
>> On 12/12/2023 5:17 AM, Maxime Coquelin wrote:
>>> This patch introduces a LSM hook for devices creation,
>>> destruction (ioctl()) and opening (open()) operations,
>>> checking the application is allowed to perform these
>>> operations for the Virtio device type.
>> My earlier comments on a vduse specific LSM hook still hold.
>> I would much prefer to see a device permissions hook(s) that
>> are useful for devices in general. Not just vduse devices.
>> I know that there are already some very special purpose LSM
>> hooks, but the experience with maintaining them is why I don't
>> want more of them. 
> What exactly does this mean?

You have proposed an LSM hook that is only useful for vduse.
You want to implement a set of controls that only apply to vduse.
I can't help but think that if someone (i.e. you) wants to control
device creation for vduse that there could well be a use case for
control over device creation for some other set of devices. It is
quite possible that someone out there is desperately trying to
solve the same problem you have, but with a different device.

I have no desire to have to deal with
	security_vduse_perm_check()
	security_odddev_perm_check()
	...
	security_evendev_perm_check()

when we should be able to have
	security_device_perm_check()

that can service them all.


>  Devices like tap etc? How do we
> find them all though?

I'm not suggesting you find them all. I'm suggesting that you provide
an interface that someone could use if they wanted to. I think you
will be surprised how many will appear (with complaints about the
interface you propose, of course) if you implement a generally useful
LSM hook.

>
>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>> ---
>>>  MAINTAINERS                         |  1 +
>>>  drivers/vdpa/vdpa_user/vduse_dev.c  | 13 ++++++++++++
>>>  include/linux/lsm_hook_defs.h       |  2 ++
>>>  include/linux/security.h            |  6 ++++++
>>>  include/linux/vduse.h               | 14 +++++++++++++
>>>  security/security.c                 | 15 ++++++++++++++
>>>  security/selinux/hooks.c            | 32 +++++++++++++++++++++++++++++
>>>  security/selinux/include/classmap.h |  2 ++
>>>  8 files changed, 85 insertions(+)
>>>  create mode 100644 include/linux/vduse.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a0fb0df07b43..4e83b14358d2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -23040,6 +23040,7 @@ F:	drivers/net/virtio_net.c
>>>  F:	drivers/vdpa/
>>>  F:	drivers/virtio/
>>>  F:	include/linux/vdpa.h
>>> +F:	include/linux/vduse.h
>>>  F:	include/linux/virtio*.h
>>>  F:	include/linux/vringh.h
>>>  F:	include/uapi/linux/virtio_*.h
>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> index fa62825be378..59ab7eb62e20 100644
>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> @@ -8,6 +8,7 @@
>>>   *
>>>   */
>>>  
>>> +#include "linux/security.h"
>>>  #include <linux/init.h>
>>>  #include <linux/module.h>
>>>  #include <linux/cdev.h>
>>> @@ -30,6 +31,7 @@
>>>  #include <uapi/linux/virtio_blk.h>
>>>  #include <uapi/linux/virtio_ring.h>
>>>  #include <linux/mod_devicetable.h>
>>> +#include <linux/vduse.h>
>>>  
>>>  #include "iova_domain.h"
>>>  
>>> @@ -1442,6 +1444,10 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
>>>  	if (dev->connected)
>>>  		goto unlock;
>>>  
>>> +	ret = -EPERM;
>>> +	if (security_vduse_perm_check(VDUSE_PERM_OPEN, dev->device_id))
>>> +		goto unlock;
>>> +
>>>  	ret = 0;
>>>  	dev->connected = true;
>>>  	file->private_data = dev;
>>> @@ -1664,6 +1670,9 @@ static int vduse_destroy_dev(char *name)
>>>  	if (!dev)
>>>  		return -EINVAL;
>>>  
>>> +	if (security_vduse_perm_check(VDUSE_PERM_DESTROY, dev->device_id))
>>> +		return -EPERM;
>>> +
>>>  	mutex_lock(&dev->lock);
>>>  	if (dev->vdev || dev->connected) {
>>>  		mutex_unlock(&dev->lock);
>>> @@ -1828,6 +1837,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>>  	int ret;
>>>  	struct vduse_dev *dev;
>>>  
>>> +	ret = -EPERM;
>>> +	if (security_vduse_perm_check(VDUSE_PERM_CREATE, config->device_id))
>>> +		goto err;
>>> +
>>>  	ret = -EEXIST;
>>>  	if (vduse_find_dev(config->name))
>>>  		goto err;
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>> index ff217a5ce552..3930ab2ae974 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -419,3 +419,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>>>  LSM_HOOK(int, 0, uring_sqpoll, void)
>>>  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
>>>  #endif /* CONFIG_IO_URING */
>>> +
>>> +LSM_HOOK(int, 0, vduse_perm_check, enum vduse_op_perm op_perm, u32 device_id)
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 1d1df326c881..2a2054172394 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -32,6 +32,7 @@
>>>  #include <linux/string.h>
>>>  #include <linux/mm.h>
>>>  #include <linux/sockptr.h>
>>> +#include <linux/vduse.h>
>>>  
>>>  struct linux_binprm;
>>>  struct cred;
>>> @@ -484,6 +485,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>>>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>>>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>>>  int security_locked_down(enum lockdown_reason what);
>>> +int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id);
>>>  #else /* CONFIG_SECURITY */
>>>  
>>>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
>>> @@ -1395,6 +1397,10 @@ static inline int security_locked_down(enum lockdown_reason what)
>>>  {
>>>  	return 0;
>>>  }
>>> +static inline int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
>>> +{
>>> +	return 0;
>>> +}
>>>  #endif	/* CONFIG_SECURITY */
>>>  
>>>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
>>> diff --git a/include/linux/vduse.h b/include/linux/vduse.h
>>> new file mode 100644
>>> index 000000000000..7a20dcc43997
>>> --- /dev/null
>>> +++ b/include/linux/vduse.h
>>> @@ -0,0 +1,14 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _LINUX_VDUSE_H
>>> +#define _LINUX_VDUSE_H
>>> +
>>> +/*
>>> + * The permission required for a VDUSE device operation.
>>> + */
>>> +enum vduse_op_perm {
>>> +	VDUSE_PERM_CREATE,
>>> +	VDUSE_PERM_DESTROY,
>>> +	VDUSE_PERM_OPEN,
>>> +};
>>> +
>>> +#endif /* _LINUX_VDUSE_H */
>>> diff --git a/security/security.c b/security/security.c
>>> index dcb3e7014f9b..150abf85f97d 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -5337,3 +5337,18 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
>>>  	return call_int_hook(uring_cmd, 0, ioucmd);
>>>  }
>>>  #endif /* CONFIG_IO_URING */
>>> +
>>> +/**
>>> + * security_vduse_perm_check() - Check if a VDUSE device type operation is allowed
>>> + * @op_perm: the operation type
>>> + * @device_id: the Virtio device ID
>>> + *
>>> + * Check whether the Virtio device creation is allowed
>>> + *
>>> + * Return: Returns 0 if permission is granted.
>>> + */
>>> +int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
>>> +{
>>> +	return call_int_hook(vduse_perm_check, 0, op_perm, device_id);
>>> +}
>>> +EXPORT_SYMBOL(security_vduse_perm_check);
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index feda711c6b7b..18845e4f682f 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -21,6 +21,8 @@
>>>   *  Copyright (C) 2016 Mellanox Technologies
>>>   */
>>>  
>>> +#include "av_permissions.h"
>>> +#include "linux/vduse.h"
>>>  #include <linux/init.h>
>>>  #include <linux/kd.h>
>>>  #include <linux/kernel.h>
>>> @@ -92,6 +94,7 @@
>>>  #include <linux/fsnotify.h>
>>>  #include <linux/fanotify.h>
>>>  #include <linux/io_uring.h>
>>> +#include <uapi/linux/virtio_ids.h>
>>>  
>>>  #include "avc.h"
>>>  #include "objsec.h"
>>> @@ -6950,6 +6953,34 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>>>  }
>>>  #endif /* CONFIG_IO_URING */
>>>  
>>> +static int selinux_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
>>> +{
>>> +	u32 requested_op, requested_type, sid = current_sid();
>>> +	int ret;
>>> +
>>> +	if (op_perm == VDUSE_PERM_CREATE)
>>> +		requested_op = VDUSE__CREATE;
>>> +	else if (op_perm == VDUSE__DESTROY)
>>> +		requested_op = VDUSE__DESTROY;
>>> +	else if (op_perm == VDUSE_PERM_OPEN)
>>> +		requested_op = VDUSE__OPEN;
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_op, NULL);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (device_id == VIRTIO_ID_NET)
>>> +		requested_type = VDUSE__NET;
>>> +	else if (device_id == VIRTIO_ID_BLOCK)
>>> +		requested_type = VDUSE__BLOCK;
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_type, NULL);
>>> +}
>>> +
>>>  /*
>>>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>>>   * 1. any hooks that don't belong to (2.) or (3.) below,
>>> @@ -7243,6 +7274,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>>  #ifdef CONFIG_PERF_EVENTS
>>>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>>>  #endif
>>> +	LSM_HOOK_INIT(vduse_perm_check, selinux_vduse_perm_check),
>>>  };
>>>  
>>>  static __init int selinux_init(void)
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>> index a3c380775d41..b0a358cbac1c 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
>>>  	  { "override_creds", "sqpoll", "cmd", NULL } },
>>>  	{ "user_namespace",
>>>  	  { "create", NULL } },
>>> +	{ "vduse",
>>> +	  { "create", "destroy", "open", "net", "block", NULL} },
>>>  	{ NULL }
>>>    };
>>>  
>
