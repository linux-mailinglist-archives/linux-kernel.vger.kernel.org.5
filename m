Return-Path: <linux-kernel+bounces-5115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D18186B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464E71C23F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABC1862B;
	Tue, 19 Dec 2023 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xCDBLGAm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qoUNWXG3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xCDBLGAm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qoUNWXG3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5D18622
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4122C210F6;
	Tue, 19 Dec 2023 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8isFFGX5+9esQAtJvvPdJrw2W21fGJe+4EuBeGsdNQ=;
	b=xCDBLGAmlZFLuG0Gk9uwe/LuAXC/6SYrk3pVej9Hjy7SCFKB2csDcQmIqTHFXVJyQ6xhhv
	KuY02T5aO3Uoho1/Nc/KnU+rTbncRggoh0IRHjExpN4DvaJHCQSessdERdtwq7R4SdK5rv
	Qd8fC+DnnIGp4pu/xr59UHTkaA54pdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8isFFGX5+9esQAtJvvPdJrw2W21fGJe+4EuBeGsdNQ=;
	b=qoUNWXG32rt75naKgfcTJee2NCWaggr4XAkvxar4rgVRc9qOMuEDyw7rlomLY81r1WzhR4
	MaqZCEAp+sHC/hAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8isFFGX5+9esQAtJvvPdJrw2W21fGJe+4EuBeGsdNQ=;
	b=xCDBLGAmlZFLuG0Gk9uwe/LuAXC/6SYrk3pVej9Hjy7SCFKB2csDcQmIqTHFXVJyQ6xhhv
	KuY02T5aO3Uoho1/Nc/KnU+rTbncRggoh0IRHjExpN4DvaJHCQSessdERdtwq7R4SdK5rv
	Qd8fC+DnnIGp4pu/xr59UHTkaA54pdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8isFFGX5+9esQAtJvvPdJrw2W21fGJe+4EuBeGsdNQ=;
	b=qoUNWXG32rt75naKgfcTJee2NCWaggr4XAkvxar4rgVRc9qOMuEDyw7rlomLY81r1WzhR4
	MaqZCEAp+sHC/hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8C941375D;
	Tue, 19 Dec 2023 11:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xh1LWSEgWXVOQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:54:12 +0000
Message-ID: <c40a4b0e-fb0e-40fa-985c-92c6895eb831@suse.de>
Date: Tue, 19 Dec 2023 12:54:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] nvmet-fc: add extensive debug logging
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-18-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-18-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xCDBLGAm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qoUNWXG3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 4122C210F6
X-Spam-Flag: NO

On 12/18/23 16:31, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Well ... all previous patches had 'XX/16', only this has '17/17'.
Late addendum?
But in either case, please ensure correct counting (and spelling!)
on the next submission.

> ---
>   drivers/nvme/target/configfs.c |   4 +
>   drivers/nvme/target/core.c     |  13 ++++
>   drivers/nvme/target/fc.c       | 132 +++++++++++++++++++++++++++++----
>   3 files changed, 135 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e307a044b1a1..ea05e8c62d4b 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -965,6 +965,7 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   			goto out_free_link;
>   	}
>   
> +	pr_info("%s: %s\n", __func__, subsys->subsysnqn);

If this is debug logging, would 'pr_debug' be more accurate?

>   	if (list_empty(&port->subsystems)) {
>   		ret = nvmet_enable_port(port);
>   		if (ret)
> @@ -1050,6 +1051,7 @@ static int nvmet_allowed_hosts_allow_link(struct config_item *parent,
>   		if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
>   			goto out_free_link;
>   	}
> +	pr_info("%s: adding hostnqn %s\n", __func__, nvmet_host_name(host));
>   	list_add_tail(&link->entry, &subsys->hosts);
>   	nvmet_subsys_disc_changed(subsys, host);
>   
> @@ -1879,6 +1881,8 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   	u16 portid;
>   	u32 i;
>   
> +	pr_info("%s\n", __func__);
> +
The meaning of this is ... what?
Of course this function is called when a port is created. So why do you 
need to log that in the message log?

>   	if (kstrtou16(name, 0, &portid))
>   		return ERR_PTR(-EINVAL);
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..4d5a9e4fcc9d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -308,8 +308,11 @@ void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *subsys)
>   {
>   	struct nvmet_ctrl *ctrl;
>   
> +	pr_info("%s: subsys %s port %p\n", __func__, subsys->subsysnqn, port);
> +
pr_debug()

>   	mutex_lock(&subsys->lock);
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		pr_info("%s: ctrl %p ctrl->port %p\n", __func__, ctrl, ctrl->port);
>   		if (ctrl->port == port)
>   			ctrl->ops->delete_ctrl(ctrl);
>   	}
> @@ -1458,6 +1461,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	mutex_unlock(&subsys->lock);
>   
>   	*ctrlp = ctrl;
> +
> +	pr_info("%s: ctrl %p, subsysnqn %s hostnqn %s\n", __func__, ctrl, subsysnqn, hostnqn);

Wouldn't it be better to list the controller id, too?

>   	return 0;
>   
>   out_free_sqs:
> @@ -1477,6 +1482,8 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
>   	struct nvmet_subsys *subsys = ctrl->subsys;
>   
> +	pr_info("%s: ctrl %p %s\n", __func__, ctrl, ctrl->subsysnqn);
> +

Please, no pointer, use the controller id instead.

>   	mutex_lock(&subsys->lock);
>   	nvmet_release_p2p_ns_map(ctrl);
>   	list_del(&ctrl->subsys_entry);
> @@ -1550,6 +1557,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   	char serial[NVMET_SN_MAX_SIZE / 2];
>   	int ret;
>   
> +	pr_info("%s\n", __func__);
> +
See above. Pretty pointless.

>   	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>   	if (!subsys)
>   		return ERR_PTR(-ENOMEM);
> @@ -1620,6 +1629,8 @@ static void nvmet_subsys_free(struct kref *ref)
>   
>   	WARN_ON_ONCE(!xa_empty(&subsys->namespaces));
>   
> +	pr_info("%s\n", __func__);
> +
>   	xa_destroy(&subsys->namespaces);
>   	nvmet_passthru_subsys_free(subsys);
>   
> @@ -1633,6 +1644,8 @@ void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
>   {
>   	struct nvmet_ctrl *ctrl;
>   
> +	pr_info("%s\n", __func__);
> +
>   	mutex_lock(&subsys->lock);
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>   		ctrl->ops->delete_ctrl(ctrl);
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 455d35ef97eb..d50ff29697fc 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -242,6 +242,31 @@ static LIST_HEAD(nvmet_fc_target_list);
>   static DEFINE_IDA(nvmet_fc_tgtport_cnt);
>   static LIST_HEAD(nvmet_fc_portentry_list);
>   
> +static void __nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
> +static int __nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
> +
> +#if 1
> +#define nvmet_fc_tgtport_put(p)						\
> +({									\
> +	pr_info("nvmet_fc_tgtport_put: %p %d %s:%d\n",	\
> +		p, atomic_read(&p->ref.refcount.refs),			\
> +		__func__, __LINE__);					\
> +	__nvmet_fc_tgtport_put(p);					\
> +})
> +
> +#define nvmet_fc_tgtport_get(p)						\
> +({									\
> +	int ___r = __nvmet_fc_tgtport_get(p);				\
> +									\
> +	pr_info("nvmet_fc_tgtport_get: %p %d %s:%d\n",			\
> +		p, atomic_read(&p->ref.refcount.refs),			\
> +		__func__, __LINE__);					\
> +	___r;								\
> +})
> +#else
> +#define nvmet_fc_tgtport_put(p) __nvmet_fc_tgtport_put(p)
> +#define nvmet_fc_tgtport_get(p) __nvmet_fc_tgtport_get(p)
> +#endif
>   
>   static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
>   static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
> @@ -252,12 +277,84 @@ static void nvmet_fc_put_tgtport_work(struct work_struct *work)
>   
>   	nvmet_fc_tgtport_put(tgtport);
>   }
> -static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
> -static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
> -static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
> -static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
> -static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
> -static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
> +static void __nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
> +static int __nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
> +
> +#if 1
> +#define nvmet_fc_tgt_a_put(a)						\
> +({									\
> +	pr_info("nvmet_fc_tgt_a_put: %d %d %s:%d \n",			\
> +		a->a_id, atomic_read(&a->ref.refcount.refs),		\
> +		__func__, __LINE__);					\
> +	__nvmet_fc_tgt_a_put(a);					\
> +})
> +
> +#define nvmet_fc_tgt_a_get(a)						\
> +({									\
> +	int ___r = __nvmet_fc_tgt_a_get(a);				\
> +									\
> +	pr_info("nvmet_fc_tgt_a_get: %d %d %s:%d\n",			\
> +		a->a_id, atomic_read(&a->ref.refcount.refs),		\
> +		__func__, __LINE__);					\
> +	___r;								\
> +})
> +#else
> +#define nvmet_fc_tgt_a_put(a) __nvmet_fc_tgt_a_put(a)
> +#define nvmet_fc_tgt_a_get(a) __nvmet_fc_tgt_a_get(a)
> +#endif
> +
> +static void __nvmet_fc_hostport_put(struct nvmet_fc_hostport *hostport);
> +static int __nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport);
> +
> +#if 0
> +#define nvmet_fc_hostport_put(p)					\
> +({									\
> +	pr_info("nvmet_fc_hostport_put: %p %d %s:%d\n",			\
> +		p, atomic_read(&p->ref.refcount.refs),			\
> +		__func__, __LINE__);					\
> +	__nvmet_fc_hostport_put(p);					\
> +})
> +
> +#define nvmet_fc_hostport_get(p)					\
> +({									\
> +	int ___r = __nvmet_fc_hostport_get(p);				\
> +									\
> +	pr_info("nvmet_fc_hostport_get: %p %d %s:%d\n",			\
> +		p, atomic_read(&p->ref.refcount.refs),			\
> +		__func__, __LINE__);					\
> +	___r;								\
> +})
> +#else
> +#define nvmet_fc_hostport_put(p) __nvmet_fc_hostport_put(p)
> +#define nvmet_fc_hostport_get(p) __nvmet_fc_hostport_get(p)
> +#endif
> +
> +static void __nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
> +static int __nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
> +
> +#if 0
If '0'?
Please, no.
Use dynamic debugging.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


