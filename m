Return-Path: <linux-kernel+bounces-132830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45E899AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D371C2122A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBF14F9D3;
	Fri,  5 Apr 2024 10:32:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F015748A;
	Fri,  5 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313129; cv=none; b=qDfk417naFEjJwaKOf7PM1BGdv0aZS+PYXZ9j7oTMVkLUZnVSxrURWn+EsH/nWU8/VG6BD+Wu3khFhNG94Dk9w+902iMwYTeK2sU1BhI+cb1OAmM4YK14QBSfPqrewV7jCb6c712stHxE1amVabfKawm4G+oLkYNbLTasNncQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313129; c=relaxed/simple;
	bh=5pktSa30WQero5rylyflhqmRgsxASuna4r7EF7U71Ww=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEhli0PeyKqVaZYzH6Q/0WEXTps5qfCy2KD0rtnUPQWkm0bz8vUw0JOdhif1HBjk2DFcupxumt0HPukONUfy279WDWPdH+rnTdqgEbtICcdEw95luk7JmCSaHF0L1+nGYrWUVVbGwoeP0qen+51kbhVu+ITPmb/ygPYlF6HU/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9vrt3WsGz6JB8S;
	Fri,  5 Apr 2024 18:30:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 31ED51400CD;
	Fri,  5 Apr 2024 18:32:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 11:32:01 +0100
Date: Fri, 5 Apr 2024 11:32:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <sudeep.holla@arm.com>,
	<jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <20240405113200.00002da9@Huawei.com>
In-Reply-To: <20240404062347.3219795-3-cristian.marussi@arm.com>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
	<20240404062347.3219795-3-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  4 Apr 2024 07:23:47 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add support for ARM MHUv3 mailbox controller.
>=20
> Support is limited to the MHUv3 Doorbell extension using only the PBX/MBX
> combined interrupts.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Drive by review (I was curious what this was :)


> diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
> new file mode 100644
> index 000000000000..e4125568bec0
> --- /dev/null
> +++ b/drivers/mailbox/arm_mhuv3.c
> @@ -0,0 +1,1063 @@

> +struct dummy_page {
> +	u8 pad[0x1000];
> +} __packed;
> +
> +struct mhu3_pbx_frame_reg {
> +	struct ctrl_page ctrl;
> +	struct pdbcw_page dbcw[MHUV3_DBCW_MAX];
> +	struct dummy_page ffcw;
> +	struct dummy_page fcw;
> +	u8 pad[0xF000 - 0x4000];
> +	struct dummy_page impdef;
> +} __packed;
> +
> +struct mhu3_mbx_frame_reg {
> +	struct ctrl_page ctrl;
> +	struct mdbcw_page dbcw[MHUV3_DBCW_MAX];
> +	struct dummy_page ffcw;
> +	struct dummy_page fcw;
> +	u8 pad[0xF000 - 0x4000];
Magic, numbers,  Maybe give them a definition or base them on something
meaningful such as structure offsets?=20

> +	struct dummy_page impdef;
> +} __packed;
> +
> +/* Macro for reading a bitfield within a physically mapped packed struct=
 */
> +#define readl_relaxed_bitfield(_regptr, _field)				\
> +	({								\
> +		u32 _rval;						\
> +		typeof(_regptr) _rptr =3D _regptr;			\
> +		_rval =3D readl_relaxed(_rptr);				\
> +		((typeof(*_rptr) __force *)(&_rval))->_field;		\
> +	})
> +
> +/* Macro for writing a bitfield within a physically mapped packed struct=
 */
> +#define writel_relaxed_bitfield(_value, _regptr, _field)		\
> +	({								\
> +		u32 _rval;						\
> +		typeof(_regptr) _rptr =3D _regptr;			\
> +		_rval =3D readl_relaxed(_rptr);				\
> +		((typeof(*_rptr) __force *)(&_rval))->_field =3D _value;	\
> +		writel_relaxed(_rval, _rptr);				\
> +	})
Similar, yet slightly different from ones in arm_mhuv2.c?  Why the differen=
ces
and can these be shared code in a suitable header?
> +
> +/* =3D=3D=3D=3D=3D=3D MHUv3 data structures =3D=3D=3D=3D=3D=3D */
> +
> +enum mhuv3_frame {
> +	PBX_FRAME,
> +	MBX_FRAME
Trailing commas for last entries in enums unless they are in some sense ter=
minators.
> +};
> +
> +static char *mhuv3_str[] =3D {
> +	"PBX",
> +	"MBX"
> +};
> +
> +enum mhuv3_extension_type {
> +	FIRST_EXT =3D 0,
As mentioned inline, 0 is kind of default assumption for first so I wouldn'=
t define it.

> +	DBE_EXT =3D FIRST_EXT,
> +	FCE_EXT,
> +	FE_EXT,
> +	MAX_EXT
That's one past normal meeting of MAX,  maybe call it COUNT, or NUM?

> +};

> +static int mhuv3_doorbell_send_data(struct mhuv3 *mhu, struct mbox_chan =
*chan,
> +				    void *arg)
> +{
> +	int ret =3D 0;
> +	struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +	struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&e->pending_lock, flags);

guard()  then you can do earlier returns and end up with cleaner code.


> +	/* Only one in-flight Transfer is allowed per-doorbell */
> +	if (!(e->pending_db[priv->ch_idx] & BIT(priv->doorbell))) {
> +		e->pending_db[priv->ch_idx] |=3D BIT(priv->doorbell);
> +		writel_relaxed(BIT(priv->doorbell),
> +			       &mhu->pbx->dbcw[priv->ch_idx].set);
> +	} else {
> +		ret =3D -EBUSY;
> +	}
> +	spin_unlock_irqrestore(&e->pending_lock, flags);
> +
> +	return ret;
> +}
>
> +
> +static struct mbox_chan *mhuv3_dbe_chan_from_comb_irq_get(struct mhuv3 *=
mhu)
> +{
> +	int i;
> +	struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	for (i =3D 0; i < MHUV3_DBCH_CMB_INT_ST_REG_CNT; i++) {
> +		unsigned int channel, db =3D MHUV3_INVALID_DOORBELL;
> +		u32 cmb_st, st;
> +
> +		cmb_st =3D readl_relaxed(&mhu->ctrl->dbch_int_st[i]);
> +		if (!cmb_st)
> +			continue;
> +
> +		channel =3D i * MHUV3_STAT_BITS + __builtin_ctz(cmb_st);
> +		if (channel >=3D e->max_chans) {
> +			dev_err(dev, "Invalid %s channel:%d\n",
> +				mhuv3_str[mhu->frame], channel);

return here rather than breaking out the loop. It is easier to follow
given nothing is done after the loop

> +			break;
> +		}
> +
> +		if (mhu->frame =3D=3D PBX_FRAME) {
> +			unsigned long flags;
> +			u32 active_dbs, fired_dbs;
> +
> +			st =3D readl_relaxed_bitfield(&mhu->pbx->dbcw[channel].int_st,
> +						    tfr_ack);
> +			if (!st) {
> +				dev_warn(dev, "Spurios IRQ on %s channel:%d\n",
Spell check.  Spurious.

> +					 mhuv3_str[mhu->frame], channel);
> +				continue;
> +			}
> +
> +			active_dbs =3D readl_relaxed(&mhu->pbx->dbcw[channel].st);
> +			spin_lock_irqsave(&e->pending_lock, flags);
> +			fired_dbs =3D e->pending_db[channel] & ~active_dbs;
> +			if (fired_dbs) {
> +				db =3D __builtin_ctz(fired_dbs);
> +				e->pending_db[channel] &=3D ~BIT(db);
> +				fired_dbs &=3D ~BIT(db);
> +			}
> +			spin_unlock_irqrestore(&e->pending_lock, flags);
> +
> +			/* Clear TFR Ack if no more doorbells pending */
> +			if (!fired_dbs)
> +				writel_relaxed_bitfield(0x1,
> +							&mhu->pbx->dbcw[channel].int_clr,
> +							tfr_ack);
> +		} else {
> +			st =3D readl_relaxed(&mhu->mbx->dbcw[channel].st_msk);
> +			if (!st) {
> +				dev_warn(dev, "Spurios IRQ on %s channel:%d\n",
> +					 mhuv3_str[mhu->frame], channel);
> +				continue;
> +			}
> +			db =3D __builtin_ctz(st);
> +		}
> +
> +		if (db !=3D MHUV3_INVALID_DOORBELL) {
> +			dev_dbg(dev, "Found %s ch[%d]/db[%d]\n",
> +				mhuv3_str[mhu->frame], channel, db);
> +
> +			return &mhu->mbox.chans[channel * MHUV3_STAT_BITS + db];
> +		}
> +	}
> +
> +	return ERR_PTR(-EIO);
> +}
> +
> +static int mhuv3_dbe_init(struct mhuv3 *mhu)
> +{
> +	struct mhuv3_extension *e;
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, dbe_spt))
> +		return 0;
> +
> +	dev_dbg(dev, "%s: Initializing DBE Extension.\n", mhuv3_str[mhu->frame]=
);
> +
> +	e =3D devm_kzalloc(dev, sizeof(*e), GFP_KERNEL);
> +	if (!e)
> +		return -ENOMEM;
> +
> +	e->type =3D DBE_EXT;
> +	/* Note that, by the spec, the number of channels is (num_dbch + 1) */
> +	e->max_chans =3D
> +		readl_relaxed_bitfield(&mhu->ctrl->dbch_cfg0, num_dbch) + 1;
> +	e->mbox_of_xlate =3D mhuv3_dbe_mbox_of_xlate;
> +	e->combined_irq_setup =3D mhuv3_dbe_combined_irq_setup;
> +	e->channels_init =3D mhuv3_dbe_channels_init;
> +	e->chan_from_comb_irq_get =3D mhuv3_dbe_chan_from_comb_irq_get;
> +
> +	mhu->tot_chans +=3D e->max_chans * MHUV3_STAT_BITS;
> +	mhu->ext[DBE_EXT] =3D e;
> +
> +	dev_info(dev, "%s: found %d DBE channels.\n",
> +		 mhuv3_str[mhu->frame], e->max_chans);
dev_dbg() probably more appropriate.

> +
> +	return 0;
> +}
> +
> +static int mhuv3_fce_init(struct mhuv3 *mhu)
> +{
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fce_spt))
> +		return 0;
> +
> +	dev_dbg(dev, "%s: FCE Extension not supported by driver.\n",
> +		mhuv3_str[mhu->frame]);
> +
> +	return 0;
> +}
> +
> +static int mhuv3_fe_init(struct mhuv3 *mhu)
> +{
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fe_spt))
> +		return 0;
> +
> +	dev_dbg(dev, "%s: FE Extension not supported by driver.\n",
> +		mhuv3_str[mhu->frame]);
> +
> +	return 0;
> +}
> +
> +static mhuv3_extension_initializer mhuv3_extension_init[MAX_EXT] =3D {
> +	mhuv3_dbe_init,
> +	mhuv3_fce_init,
> +	mhuv3_fe_init,
> +};
> +
> +static int mhuv3_initialize_channels(struct device *dev, struct mhuv3 *m=
hu)
> +{
> +	int i, ret =3D 0;
> +	struct mbox_controller *mbox =3D &mhu->mbox;
> +
> +	mbox->chans =3D devm_kcalloc(dev, mhu->tot_chans,
> +				   sizeof(*mbox->chans), GFP_KERNEL);
> +	if (!mbox->chans)
> +		return -ENOMEM;
> +
> +	for (i =3D FIRST_EXT; i < MAX_EXT && !ret; i++)
Why this dance with FIRST_EXT if it is always 0?  Cleaner to just use 0.

> +		if (mhu->ext[i])
> +			ret =3D mhu->ext[i]->channels_init(mhu);
> +
> +	return ret;
> +}
> +
> +static struct mbox_chan *mhuv3_mbox_of_xlate(struct mbox_controller *mbo=
x,
> +					     const struct of_phandle_args *pa)
> +{
> +	unsigned int type, channel, param;
> +	struct mhuv3 *mhu =3D mhu_from_mbox(mbox);
> +
> +	if (pa->args_count !=3D MHUV3_MBOX_CELLS)
> +		return ERR_PTR(-EINVAL);
> +
> +	type =3D pa->args[MHUV3_MBOX_CELL_TYPE];
> +	if (type >=3D MAX_EXT)
> +		return ERR_PTR(-EINVAL);
> +
> +	channel =3D pa->args[MHUV3_MBOX_CELL_CHWN];
> +	param =3D pa->args[MHUV3_MBOX_CELL_PARAM];
> +
> +	return mhu->ext[type]->mbox_of_xlate(mhu, channel, param);
> +}
> +
> +static int mhuv3_frame_init(struct mhuv3 *mhu, void __iomem *regs)
> +{
> +	int i, ret =3D 0;
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	mhu->ctrl =3D regs;
> +	mhu->frame =3D readl_relaxed_bitfield(&mhu->ctrl->blk_id, blk_id);
> +	if (mhu->frame > MBX_FRAME) {
> +		dev_err(dev, "Invalid Frame type- %d\n", mhu->frame);
> +		return -EINVAL;
dev_err_probe() etc (see later)

> +	}
> +
> +	mhu->major =3D readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_major_rev);
> +	mhu->minor =3D readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_minor_rev);
> +	if (mhu->major !=3D MHUV3_MAJOR_VERSION) {
> +		dev_warn(dev, "Unsupported MHU %s block - major:%d  minor:%d\n",
> +			 mhuv3_str[mhu->frame], mhu->major, mhu->minor);

You are treating it as an error, so why only a warning?

> +		return -EINVAL;
> +	}
> +	mhu->auto_op_full =3D !!readl_relaxed_bitfield(&mhu->ctrl->feat_spt1,
> +						     auto_op_spt);
> +	/* Request the PBX/MBX to remain operational */
> +	if (mhu->auto_op_full)
> +		writel_relaxed_bitfield(0x1, &mhu->ctrl->ctrl, op_req);
> +
> +	dev_dbg(dev, "Found MHU %s block - major:%d  minor:%d\n",
> +		mhuv3_str[mhu->frame], mhu->major, mhu->minor);
> +
> +	if (mhu->frame =3D=3D PBX_FRAME)
> +		mhu->pbx =3D regs;
> +	else
> +		mhu->mbx =3D regs;
> +
> +	for (i =3D FIRST_EXT; i < MAX_EXT && !ret; i++)
> +		ret =3D mhuv3_extension_init[i](mhu);

Only dbe_init() returns any errors, so if I ready this correctly you always
eat that error.=20

> +
> +	return ret;
> +}
> +
> +static irqreturn_t mhuv3_pbx_comb_interrupt(int irq, void *arg)
> +{
> +	int ret =3D IRQ_NONE;
> +	unsigned int i, found =3D 0;
> +	struct mhuv3 *mhu =3D arg;
> +	struct device *dev =3D mhu->mbox.dev;
> +	struct mbox_chan *chan;
> +
> +	for (i =3D FIRST_EXT; i < MAX_EXT; i++) {
> +		/* FCE does not participate to the PBX combined */
> +		if (i =3D=3D FCE_EXT || !mhu->ext[i])
> +			continue;
> +
> +		chan =3D mhu->ext[i]->chan_from_comb_irq_get(mhu);
> +		if (!IS_ERR(chan)) {

		if (IS_ERR(chan))
			continue;

will reduce indent and give more readable code.

> +			struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +			found++;
> +			if (chan->cl) {
> +				mbox_chan_txdone(chan, 0);
> +				ret =3D IRQ_HANDLED;
> +			} else {
> +				dev_warn(dev,
> +					 "TX Ack on UNBOUND channel (%u)\n",
> +					 priv->ch_idx);
> +			}
> +		}
> +	}
> +
> +	if (!found)
> +		dev_warn_once(dev, "Failed to find channel for the TX interrupt\n");
> +
> +	return ret;
> +}
> +
> +static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
> +{
> +	int ret =3D IRQ_NONE;
> +	unsigned int i, found =3D 0;
> +	struct mhuv3 *mhu =3D arg;
> +	struct device *dev =3D mhu->mbox.dev;
> +	struct mbox_chan *chan;
> +
> +	for (i =3D FIRST_EXT; i < MAX_EXT; i++) {
> +		if (!mhu->ext[i])
> +			continue;
> +
> +		/* Process any extension which could be source of the IRQ */
> +		chan =3D mhu->ext[i]->chan_from_comb_irq_get(mhu);
> +		if (!IS_ERR(chan)) {

		if (IS_ERR(chan))
			continue;

is going to be easier to read.

> +			void *data =3D NULL;
> +			struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +			found++;
> +			/* Read and acknowledge optional in-band LE data first. */
> +			if (priv->ops->read_data)
> +				data =3D priv->ops->read_data(mhu, chan);
> +
> +			if (chan->cl && !IS_ERR(data)) {
> +				mbox_chan_received_data(chan, data);
> +				ret =3D IRQ_HANDLED;
> +			} else if (!chan->cl) {
> +				dev_warn(dev,
> +					 "RX Data on UNBOUND channel (%u)\n",
> +					 priv->ch_idx);
> +			} else {
> +				dev_err(dev, "Failed to read data: %lu\n",
> +					PTR_ERR(data));
> +			}

I'd be tempted to factor out this code block into another function as I thi=
nk
that will allow you to deal with the errors more directly.

> +
> +			if (!IS_ERR(data))
> +				kfree(data);
> +
> +			/*
> +			 * Acknowledge transfer after any possible optional
> +			 * out-of-band data has also been retrieved via
> +			 * mbox_chan_received_data().
> +			 */
> +			if (priv->ops->rx_complete)
> +				priv->ops->rx_complete(mhu, chan);
> +		}
> +	}
> +
> +	if (!found)
> +		dev_warn_once(dev, "Failed to find channel for the RX interrupt\n");
> +
> +	return ret;
> +}
> +
> +static int mhuv3_setup_pbx(struct mhuv3 *mhu)
> +{
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	mhu->mbox.ops =3D &mhuv3_sender_ops;
> +
> +	if (mhu->cmb_irq > 0) {
> +		int ret;
> +
> +		ret =3D devm_request_threaded_irq(dev, mhu->cmb_irq, NULL,
> +						mhuv3_pbx_comb_interrupt,
> +						IRQF_ONESHOT, "mhuv3-pbx", mhu);
> +		if (!ret) {
> +			int i;
> +
> +			mhu->mbox.txdone_irq =3D true;
> +			mhu->mbox.txdone_poll =3D false;
> +
> +			for (i =3D FIRST_EXT; i < MAX_EXT; i++)
> +				if (mhu->ext[i])
> +					mhu->ext[i]->combined_irq_setup(mhu);
> +
> +			dev_dbg(dev, "MHUv3 PBX IRQs initialized.\n");
> +
> +			return 0;
> +		}
> +
> +		dev_err(dev, "Failed to request PBX IRQ - ret:%d", ret);

If an irq was provided and it failed, I'd just return an error, not muddle =
on.
Broken system.  If it's not an 'error' then don't use dev_err()

Papering over this leads to an odd code flow with if (!ret) so it would
be nice not to bother unless there is a strong reason to carry on.


> +	}
> +
> +	dev_info(dev, "Using PBX in Tx polling mode.\n");

That's noisy.  dev_dbg() perhaps?

> +	mhu->mbox.txdone_irq =3D false;
> +	mhu->mbox.txdone_poll =3D true;
> +	mhu->mbox.txpoll_period =3D 1;
> +
> +	return 0;
> +}
> +
> +static int mhuv3_setup_mbx(struct mhuv3 *mhu)
> +{
> +	int ret, i;
> +	struct device *dev =3D mhu->mbox.dev;
> +
> +	mhu->mbox.ops =3D &mhuv3_receiver_ops;
> +
> +	if (mhu->cmb_irq <=3D 0) {
> +		dev_err(dev, "Missing MBX combined IRQ !\n");
		return dev_err_probe()
here as I think it's only called form init.  Sure you might not
need the deferred handling it provides but it still leads to
cleaner code and no one has to think about whether deferal might
happen or not.

> +		return -EINVAL;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(dev, mhu->cmb_irq, NULL,
> +					mhuv3_mbx_comb_interrupt, IRQF_ONESHOT,
> +					"mhuv3-mbx", mhu);
> +	if (ret) {
> +		dev_err(dev, "Failed to request MBX IRQ - ret:%d\n", ret);
> +		return ret;

		return dev_err_probe()

> +	}
> +
> +	for (i =3D FIRST_EXT; i < MAX_EXT; i++)
> +		if (mhu->ext[i])
> +			mhu->ext[i]->combined_irq_setup(mhu);
> +
> +	dev_dbg(dev, "MHUv3 MBX IRQs initialized.\n");
> +
> +	return ret;
> +}
> +
> +static int mhuv3_irqs_init(struct mhuv3 *mhu, struct platform_device *pd=
ev)
> +{
> +	int ret;
> +
> +	dev_dbg(mhu->mbox.dev, "Initializing %s block.\n", mhuv3_str[mhu->frame=
]);
> +
> +	if (mhu->frame =3D=3D PBX_FRAME) {
> +		mhu->cmb_irq =3D platform_get_irq_byname_optional(pdev, "combined");
> +		ret =3D mhuv3_setup_pbx(mhu);

		return early is both shorter and easier to follow if people
are looking at particular paths through the function.

> +	} else {
> +		mhu->cmb_irq =3D platform_get_irq_byname(pdev, "combined");
> +		ret =3D mhuv3_setup_mbx(mhu);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mhuv3_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct mhuv3 *mhu;
> +	void __iomem *regs;
> +	struct device *dev =3D &pdev->dev;
> +
> +	mhu =3D devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> +	if (!mhu)
> +		return -ENOMEM;
> +
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	mhu->mbox.dev =3D dev;
> +	ret =3D mhuv3_frame_init(mhu, regs);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mhuv3_irqs_init(mhu, pdev);
> +	if (ret)
> +		return ret;
> +
> +	mhu->mbox.of_xlate =3D mhuv3_mbox_of_xlate;
> +	ret =3D mhuv3_initialize_channels(dev, mhu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_mbox_controller_register(dev, &mhu->mbox);
> +	if (ret)
> +		dev_err(dev, "failed to register ARM MHUv3 driver %d\n", ret);

Use dev_err_probe() to get a few things for free in probe time error messag=
es message.
		return dev_err_probe(dev, reg, "failed to register ARM HMUv3 driver\n");

	return 0;
> +
> +	platform_set_drvdata(pdev, mhu);

With all devm as suggested below, can I think drop this.

> +
> +	return ret;
> +}
> +
> +static int mhuv3_remove(struct platform_device *pdev)
> +{
> +	struct mhuv3 *mhu =3D platform_get_drvdata(pdev);
> +
> +	if (mhu->auto_op_full)
> +		writel_relaxed_bitfield(0x0, &mhu->ctrl->ctrl, op_req);
> +

=46rom a quick glance probably better to use a
devm_add_action_or_reset() so that this is turned off at
equivalent place in remove() path as where it is turned on in _init()

Only register the callback if auto_op_full()

Mixing and matching devm_ and calls in remove is a path to weird
races and corner cases so better to go all in on devm handling.

> +	return 0;
> +}
> +
> +static const struct of_device_id mhuv3_of_match[] =3D {
> +	{ .compatible =3D "arm,mhuv3", .data =3D NULL },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mhuv3_of_match);
> +
> +static struct platform_driver mhuv3_driver =3D {
> +	.driver =3D {
> +		.name =3D "arm-mhuv3-mailbox",
> +		.of_match_table =3D mhuv3_of_match,
> +	},
> +	.probe =3D mhuv3_probe,
> +	.remove =3D mhuv3_remove,
> +};
> +module_platform_driver(mhuv3_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ARM MHUv3 Driver");
> +MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");


