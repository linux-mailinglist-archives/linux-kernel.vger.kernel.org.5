Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0943D7730D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjHGVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHGVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:00:21 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596141703
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691442018; bh=dsi5bDxPyFnmzwBub7oKLaLhaSnl1mmo0Lw0XBGaIik=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=h+87rYRJHubtpDrGe9S/rqXk8hu4GnPXwzw4g65zXXpd39dFlKgLUdUPfn+7WH50GHWhGC5LJMGPafiYG4X6NN8lmGKVHUiUyfCDkC57fqd+/yKA4xEozMYGdiCiH7A/sqx5hVnLE2C6vf+AAYyEJEw/6VTf12XX/59yc5lVsMEXMbIiQzLBinewfK15OG7aCsytNyAqSXq0vLcLVFDpE+zfoMCCT6glgtSVblPPUf4pEcQT6mIy660fUcNWDTJdjo422aXNSr+mZhBkSioTNvB9cb6yNZ2QCHYGJkqH3Qa8foSBTdjUWFVyDwYIsnA6RRrte+1G9tNHNqW5QmJurA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691442018; bh=yHZeXliEfjMJASmRV9J+r4AKTPxCp5VOd5jQOp4Vh2e=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UFSwgOp92bbPU/FrQvu+j7awUJ/fAsIpQjsIf+LiNJFtKl5z2vWGnY4fZTMY7ZielEYpZb2MgsBQ5pIhZFy3rl1DXwOb6I0Ue6DR42bmoSeIeXB5enwiDkRDMoCtFoJpMG9zkndjxoRTcJNpGkA2DdgMyZZdiR11ncslu6cNWcuQDn+4tX8VKra9ylPv3gZIRnqI087l/Cs7Sa2otK6PDyCQKXk7yDAyZl4mvXRfEHNgMPSJu33lhuaN4Y4hDApmFUHwyZeveOkXFy/YGIAudgDdyrmGNZjK2yWL3X3chLb9i7DixVHLITNqXXBXMslhmux5dUhW2+xFYxmGbbnBXA==
X-YMail-OSG: vjPv1QsVM1lLWmIMWtvhC7bI50xDZbe2U.hqkNfAnWnUcrMtNXEdEXNZdy60ySk
 mdGQShW7kFNBiHH3.i7dz_Q1p7fHYP8gyhg8RqmGJd_1siBcuzybZ_yA09gQ0c1YPhMlh0XSxQU6
 26.k2oWE2BdM6skqVvKPFfLtMGT.QLIxyKg4ZV8vVwYUUcgjYBiUuZ5TyqHhyCpKtufqzDlhO_uY
 m7wUxy1enScfFzA0pZtEoFVHLhEjtd5k2lZUufgTf3thjGhGGNBbsqn4CjFExgtmcV9RbUVKKswO
 RZP8AwaPiUojgwJ2Ebg5.FDisUFd7Dc0BNt6Qkvgzp0Z9ewbnBgDzW0cRBG1z54RCRaI0AKc5sN0
 10DjgCYbjy7mfHQoPUkRDWTdXvxIsozJbM2KbQDtq3i8mbRFLickpHxgPMnhLbrItyhvfnRZgt.K
 ENoFC8BG57P0_e7zCSaretttRPct7XHMEatfh6JkboC2HJDaFy4Ek962enIhc7.UJhrr09JYInU_
 7p33IWg4x5hR9nf3G6G3RKuusauqWpdXCIUmNgOxroU7QOY8ykgD4YLGDNmnt8VLvpDpowBKj9_J
 QjwO4G39E.1QnD4woimZ2d7EuhHLEs_NAB8HCN1tAyIHKr9_rxAkmiI3m9ZYprSG0ll58Ipvj29a
 W_RRFw.l_GOV5YwP6FsgfwiyzGhL28.7qTmWde6rg4YzAWlpsLXpPyST9HW.H54PYthEiuYjtvdh
 JtGnymXJltX3WDaVpVNFBJB47Mc.Bl8Z_hO_7B.2ExY5Ti5bWOYkPwJ378vuLoHUeuQb0tk5EjpU
 N49rraqF_.K3YpZ00lkZy2wpS2YBejUgUp87zS4vuzjZriCCq4nGAF.W69MjvAejrf0n4wPtXDpj
 VbPs8Lxb8aM0ln_73i87mPoJAVOiughF3sgFaXXjgRrQT5ekG1qpjZoQpEiYwGRWqREYTBctLmYg
 ogcNT8kmUcNYR1vLUMG3P.cAPrP3FGfDcudMRljUZad4e7ArtDvidTpUrk.FGNO.yz5hQ5U5mmOU
 cge0UXaBW48YxNkZuCmtvOktwa5M_qcu.NKTmkLtNE2gqcUp8KXnvyFFQog88eQx8TgmxntuQE8L
 86yn8FXxs8tPv4y30V.r55agZn29X6_QeOSxtOOvEYGzoVW0wqstQUCSOkw.tWYNcIrwK2QbhRuK
 aTwQQXMWXdFpl79c6JtPNvB.GJfHcV0pwZ2Dw7epC76BJ8A9kvaa_cM5ILIzG47GbV8nc5z0DdnT
 A1LPA06xPCyHcgSoAljMGPAJzPJ_TEJdk.2mlmizM18r3wwIlFsGC35944k5imMbW2jCpT2IOV1i
 ZG3bzLD_eoz5IFuL5tCRf3H3kgWrX3ritVESM8JGFtX4hu_XC2cK91KrzqVFUAafOn.dPU_HrR48
 K5iyAyfTqwwuWeLq_OHW7yaVtCnk3y6PZM8hEQsQNGOC7zvo3couD1J0ofT._0Mfev.BiBeDD8IT
 gbSIIprYHhcU.tRZS0NBmP178JfDLjmLgioOtQQ4ih4_WStCi3jyD.n8ex6.6RwhiMHyKs3wvW6i
 bfx3dh1x67mBGe0qnYUakYk95Z_otO0OB2kEl6WEx1rL1uW44BhPMuTbQe561mWBWqtbobj.y1PL
 wi4UIVplUR59.DrYiSS5se3ilck28aQJTBxsiMfrwuQI7IdK.Uas0RJnLIZ6FtzKE9.qwiaH9wS8
 Xb5wtkfJVYMUq83HjdPk0Fw_OjONStM.zWbINqKawQjK7h.32sj7N.KVXxLsTRepaDkeP.hDNNAV
 8E0QIe9j.ob2uHQwe5c7gKNDbKKpFnl.WkfRquld7lHiS3iwZrfqCrNekogfGkOYUqa3UUoOZwPn
 bhvqvefv0K5oUxYq60LOwW8.igj9_SZ37UZwS.sUII9UJHLEzMwhJcMWGsMiMKLwvMcZh878hOIv
 9bO9I2xeFzlCtH4HE95BNg03KAzbRC81XsvZeQaqc.g7AcYwVH8cauV7W7.WI3pyeqyPfCfcJSUb
 kJ18Efi33lty3NvshqSwiQ4JJg5HM9_njwwxWaM.4AyVoa1AqFn6kVEVSxEPGX7FnlzBNWS3fu89
 z91vq7m5LBb2wi_DNM_gvm1bLW.dHSqeo.Ue6bFUK8umtSHY2oK7tQG2jn3t4GZdIojn.2WogAdg
 3aZqLrMLVjYrInilqlEnok66TF_ahcbS0cnmn0VoG8vBYPz3S3Jiqh0oMcwkVLZMkAACPIWFnEgO
 _wjzKIfFsOxxVffFof8Z5HwHiMHSba7urCxGY6dYeD8EC5kCt6R9ZrZ3rS4USJJ1HxefsRlfpHWX
 2Bg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 434db13a-3ea1-4533-b79a-7030afe13dfb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Aug 2023 21:00:18 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c3b558c08f60fe821be8034640107ed4;
          Mon, 07 Aug 2023 21:00:15 +0000 (UTC)
Message-ID: <d7ea58ea-32a8-26b9-79f2-dd0656e1aa1e@schaufler-ca.com>
Date:   Mon, 7 Aug 2023 14:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 05/13] Add primary TSEM implementation file.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-6-greg@enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230710102319.19716-6-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 3:23 AM, Dr. Greg wrote:
> The tsem.c file is the 'master' file in the TSEM implementation.
> It is responsible for initializing the LSM and providing
> implementions of the security event hooks implemented by TSEM.
>
> In addition to initializing the LSM, the set_ready() function
> implements a secondary initialization that is used to to indicate
> that security event modeling can begin.  This is required
> secondary to the fact that the cryptographic API's do not become
> ready until after the 'fs' phase of system initialization is
> complete.
>
> This file also handles the implementation of kernel command-line
> parameters that are used to configure the root security modeling
> namespace.
>
> The 'tsem_mode' parameter, if set to a value of 1, causes modeling
> to be not conducted for the root security modeling namespace.
> One use case is to allow development platform to develop security
> models without the overhead of full platform modeling.
>
> The 'tsem_digest' parameter is used to set the cryptographic hash
> function that is used to generate security state coefficients in
> the root model.  TSEM can use any cryptographic hash function
> implemented in the kernel, on a namespace by namespace basis.
> Subordinate modeling namespaces can select their hash function
> as part of the namespace creation process but the 'tsem_digest'
> parameter has to be used to set the function for the root
> modeling namespace.
>
> The hash function used in the root modeling namespace but be
> compiled into the kernel since the function is used before module
> loading becomes available.  The TSEM kernel configuration selects
> the SHA256 function to be included as the default cryptographic
> modeling function.
>
> The 'tsem_cache' variable sets the size of the pre-allocated
> structures that are used for security event modeling in the root
> modeling namespace.  This cache is used to support the modeling
> and export of events that run in atomic context.  The cache size
> can be set independently for each subordinate security modeling
> on a namespace by namespace basis.
>
> This file also contains the implementation of the tsem_names
> array that contains the ASCII text names that are assigned to
> each security event handler.  This name is used as one of the
> characteristics in the security state points that are generated.
> This array is also used to provide symbolic names for the export
> of security event descriptions, either through the TSEM control
> plane or for export to external trust orchestrators.
>
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  security/tsem/tsem.c | 1987 ++++++++++++++++++++++++++++++++++++++++++

Please use kernel doc comments throughout.
I've made a few minor comments below, but you need to break this up
somehow for review. Also, having the data definitions elsewhere makes
review tough.

>  1 file changed, 1987 insertions(+)
>  create mode 100644 security/tsem/tsem.c
>
> diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> new file mode 100644
> index 000000000000..8ec630354240
> --- /dev/null
> +++ b/security/tsem/tsem.c
> @@ -0,0 +1,1987 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2023 Enjellic Systems Development, LLC
> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> + *
> + * TSEM initialization infrastructure.
> + */
> +#define TRAPPED_MSG_LENGTH 128
> +
> +#define LOCKED true
> +#define NOLOCK false
> +
> +#include <linux/magic.h>
> +#include <linux/mman.h>
> +#include <linux/binfmts.h>
> +#include <linux/bpf.h>
> +#include <linux/ipv6.h>
> +
> +#include "tsem.h"
> +
> +struct lsm_blob_sizes tsem_blob_sizes __ro_after_init = {
> +	.lbs_task = sizeof(struct tsem_task),

Do you really want this for the task? It would seem you might
want to use the cred blob instead.

> +	.lbs_inode = sizeof(struct tsem_inode)
> +};
> +
> +enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT] = {
> +	TSEM_ACTION_EPERM	/* Undefined. */
> +};
> +
> +static struct tsem_model root_model = {
> +	.point_lock = __SPIN_LOCK_INITIALIZER(root_model.point_lock),
> +	.point_list = LIST_HEAD_INIT(root_model.point_list),
> +	.point_end_mutex = __MUTEX_INITIALIZER(root_model.point_end_mutex),
> +
> +	.trajectory_lock = __SPIN_LOCK_INITIALIZER(root_model.trajectory_lock),
> +	.trajectory_list = LIST_HEAD_INIT(root_model.trajectory_list),
> +	.trajectory_end_mutex = __MUTEX_INITIALIZER(root_model.trajectory_end_mutex),
> +
> +	.forensics_lock = __SPIN_LOCK_INITIALIZER(root_model.forensics_lock),
> +	.forensics_list = LIST_HEAD_INIT(root_model.forensics_list),
> +	.forensics_end_mutex = __MUTEX_INITIALIZER(root_model.forensics_end_mutex),
> +
> +	.pseudonym_mutex = __MUTEX_INITIALIZER(root_model.pseudonym_mutex),
> +	.pseudonym_list = LIST_HEAD_INIT(root_model.pseudonym_list)
> +};
> +
> +static struct tsem_context root_context;
> +
> +static int tsem_ready __ro_after_init;
> +
> +static bool tsem_available __ro_after_init;
> +
> +static unsigned int magazine_size __ro_after_init = TSEM_ROOT_MAGAZINE_SIZE;
> +
> +static bool no_root_modeling __ro_after_init;
> +
> +static char *default_hash_function __ro_after_init;
> +
> +static int __init set_magazine_size(char *magazine_value)
> +{
> +	if (kstrtouint(magazine_value, 0, &magazine_size))
> +		pr_warn("tsem: Failed to parse root cache size.\n");
> +
> +	if (!magazine_size) {
> +		pr_warn("tsem: Forcing non-zero cache size.\n");
> +		magazine_size = TSEM_ROOT_MAGAZINE_SIZE;
> +	}
> +
> +	pr_info("tsem: Setting default root cache size to %u.\n",
> +		magazine_size);
> +	return 1;
> +}
> +__setup("tsem_cache=", set_magazine_size);
> +
> +static int __init set_modeling_mode(char *mode_value)
> +{
> +	unsigned long mode = 0;
> +
> +	if (kstrtoul(mode_value, 0, &mode)) {
> +		pr_warn("tsem: Failed to parse modeling mode.\n");
> +		return 1;
> +	}
> +
> +	if (mode == 1)
> +		no_root_modeling = true;
> +	else
> +		pr_warn("tsem: Unknown mode specified.\n");
> +	return 1;
> +}
> +__setup("tsem_mode=", set_modeling_mode);
> +
> +static int __init set_default_hash_function(char *hash_function)
> +{
> +
> +	default_hash_function = hash_function;
> +	return 1;
> +}
> +__setup("tsem_digest=", set_default_hash_function);
> +
> +const char * const tsem_names[TSEM_EVENT_CNT] = {
> +	"undefined",
> +	"bprm_set_creds",
> +	"generic_event",
> +	"task_kill",
> +	"task_setpgid",
> +	"task_getpgid",
> +	"task_getsid",
> +	"task_setnice",
> +	"task_setioprio",
> +	"task_getioprio",
> +	"task_prlimit",
> +	"task_setrlimit",
> +	"task_setscheduler",
> +	"task_getscheduler",
> +	"task_prctl",
> +	"file_open",
> +	"mmap_file",
> +	"file_ioctl",
> +	"file_lock",
> +	"file_fcntl",
> +	"file_receive",
> +	"unix_stream_connect",
> +	"unix_may_send",
> +	"socket_create",
> +	"socket_connect",
> +	"socket_bind",
> +	"socket_accept",
> +	"socket_listen",
> +	"socket_socketpair",
> +	"socket_sendmsg",
> +	"socket_recvmsg",
> +	"socket_getsockname",
> +	"socket_getpeername",
> +	"socket_setsockopt",
> +	"socket_shutdown",
> +	"ptrace_traceme",
> +	"kernel_module_request",
> +	"kernel_load_data",
> +	"kernel_read_file",
> +	"sb_mount",
> +	"sb_umount",
> +	"sb_remount",
> +	"sb_pivotroot",
> +	"sb_statfs",
> +	"move_mount",
> +	"shm_associate",
> +	"shm_shmctl",
> +	"shm_shmat",
> +	"sem_associate",
> +	"sem_semctl",
> +	"sem_semop",
> +	"syslog",
> +	"settime",
> +	"quotactl",
> +	"quota_on",
> +	"msg_queue_associate",
> +	"msg_queue_msgctl",
> +	"msg_queue_msgsnd",
> +	"msg_queue_msgrcv",
> +	"ipc_permission",
> +	"key_alloc",
> +	"key_permission",
> +	"netlink_send",
> +	"inode_create",
> +	"inode_link",
> +	"inode_unlink",
> +	"inode_symlink",
> +	"inode_mkdir",
> +	"inode_rmdir",
> +	"inode_mknod",
> +	"inode_rename",
> +	"inode_setattr",
> +	"inode_getattr",
> +	"inode_setxattr",
> +	"inode_getxattr",
> +	"inode_listxattr",
> +	"inode_removexattr",
> +	"inode_killpriv",
> +	"tun_dev_create",
> +	"tun_dev_attach_queue",
> +	"tun_dev_attach",
> +	"tun_dev_open",
> +	"bpf",
> +	"bpf_map",
> +	"bpf_prog"
> +};
> +
> +static const int pseudo_filesystems[] = {
> +	PROC_SUPER_MAGIC,
> +	SYSFS_MAGIC,
> +	DEBUGFS_MAGIC,
> +	TMPFS_MAGIC,
> +	DEVPTS_SUPER_MAGIC,
> +	BINFMTFS_MAGIC,
> +	SECURITYFS_MAGIC,
> +	SELINUX_MAGIC,
> +	SMACK_MAGIC,
> +	CGROUP_SUPER_MAGIC,
> +	CGROUP2_SUPER_MAGIC,
> +	NSFS_MAGIC,
> +	EFIVARFS_MAGIC
> +};
> +
> +static bool bypass_inode(struct inode *inode)
> +{
> +	bool retn = true;
> +
> +	unsigned int lp;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		goto done;
> +
> +	for (lp = 0; lp < ARRAY_SIZE(pseudo_filesystems); ++lp)
> +		if (inode->i_sb->s_magic == pseudo_filesystems[lp])
> +			goto done;
> +	retn = false;
> +
> + done:
> +	return retn;
> +}
> +
> +static int event_action(struct tsem_context *ctx, enum tsem_event_type event)
> +{
> +	int retn = 0;
> +
> +	if (tsem_task_trusted(current))
> +		return retn;
> +
> +	if (ctx->actions[event] == TSEM_ACTION_EPERM)
> +		retn = -EPERM;
> +
> +	return retn;
> +}
> +
> +static int return_trapped_task(enum tsem_event_type event, char *msg,

Why isn't this simply "trapped_task()"?

> +			       bool locked)
> +{
> +	int retn;
> +	struct tsem_context *ctx = tsem_context(current);
> +
> +	pr_warn("Untrusted %s: comm=%s, pid=%d, parameters='%s'\n",
> +		tsem_names[event], current->comm, task_pid_nr(current), msg);
> +
> +	if (ctx->external) {
> +		retn = tsem_export_action(event, locked);
> +		if (retn)
> +			return retn;
> +	}
> +
> +	return event_action(ctx, event);
> +}
> +
> +static int return_trapped_inode(enum tsem_event_type event,

Again, really odd function name.

... and that's all I have time for.

