Return-Path: <linux-kernel+bounces-153781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FE8AD307
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41BCB26D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98930153BED;
	Mon, 22 Apr 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NW/0cHpr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D0153BC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805421; cv=none; b=HN/PO1Q0dMGVhHsYBlz2k0vrhTRtK70KuzDy55wDrWeCeFBVdHkCTIvZuZ/6dBpXrorlw8Xkj95INsh5LZDWc8zLpo874UN8N6ZDtqr6uD16cDnq5jFUy1ordJ9dwl1uKQKSkz0goskWj7CY77dHXezPu4KEH2ub+sgvm92PAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805421; c=relaxed/simple;
	bh=FdOzXEFNUc+OZlCu/kOYdXjFWUyCcJk06V2HnMjdVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRMbr9qj0Kv8hXZV6ObiLQLm6KJWszRnW5pgdxcZSM6BYnqHoyFYLHva68SGhCjFDlFpnsCrqJnJ8noW6fUsDMmpLBspH2hW2loqc4+UU0fPkkPV1ywDsOODmv2QUi6nTFkCUVg39B0iH0QgBfBVrcCZ/3use+VW30+AbhCL3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NW/0cHpr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so1203140e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713805418; x=1714410218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NnXUUQH8MJAjIBe6OWmvuNIZ5Bl23Pl7D/IBjOKqiE=;
        b=NW/0cHprNUqQE7uLZa+1WoE8uNiV8czcFe4d0OFrAY9t+hvcXVq9chQhfPsSlcjDpq
         +nN9eumhVkwO2Icv02Z6U/nZsC/Yz0oS14Hlc/lrWSD4LbgtH8c3jYFot6v4vRuvwKJH
         M25nZIgETjBI8sOopivw9GDRIWKXyqffDELga+O/N0DiHrHUpqazQ6ri7TfNrFHRRqeb
         aG7dHC4Oq/ZgjL8panQ+uljq8dDSEuAi4b4qHMJ28AEmsl4FOgUdKVEPzFnG0e9sNGLN
         fQM4N82+PAwLwWIOsgWxASXGus5pEt4mNkUwfF279qOsToD9YrUQ8fpvdb05tzdsidzV
         dS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805418; x=1714410218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NnXUUQH8MJAjIBe6OWmvuNIZ5Bl23Pl7D/IBjOKqiE=;
        b=N2hVgRirAERK8Lz+FmlHkZEPwb7f6XlHLBB3qoK5PC6cGJnAp4WbeZG5RbjE8mcMAT
         V0quqIn1qFBHvLfUAeKCGDj2e3B9FhxlQ1P5tGJVPvRzOomsz8hJm2zOsUA3vT7TYZYb
         ILXPFI3240YR30YdsSpO95wFR2R2stThfp9ncv9asllOOFaWlmwOEq5IiN8nkOVtNLs6
         ZK+h8YTgT0vY873UUfGqCrdjwjTvA+OhY6htYhtqI/OEXAZX769EzKDBtN1giWpXPMfe
         atRLZ8peOrhCuoW7VZKKu/0n3qD4YeXHUc/zAhSXd/MRQ8bVGW2GFO8gaDh2tWrArCwS
         2Jow==
X-Forwarded-Encrypted: i=1; AJvYcCVWgRZzmh80BaTUWIaQWAhRRpr5PJPQQ2OmvN/yGdzKYSc5+zCVHZVuCE5UeMoTcRptTZ7toKTpVhskTL1k2rc1i9SGpX7G76PQP/68
X-Gm-Message-State: AOJu0Yx72ixijCPG1JHS45antj3LJ7CvEw7x8VTlnwhACBLwoz5GpMIS
	CNsAItZM6Nn0MMnxYlZmsrpv0oa0cL4GjNl2karvd3uQ4cOLFPJ05UxEafH6i+g=
X-Google-Smtp-Source: AGHT+IHaxT0m+L0yQBRryqCY8ygBYcqfRLsKxwbPfMto9I8BlKPaEWgJJHcp079xFByhGgJR7hAw/A==
X-Received: by 2002:ac2:4e43:0:b0:518:973e:c34b with SMTP id f3-20020ac24e43000000b00518973ec34bmr5601450lfr.36.1713805417310;
        Mon, 22 Apr 2024 10:03:37 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906378400b00a522fb5587esm3826506ejc.144.2024.04.22.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:03:36 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:03:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 3/9] octeontx2-pf: Create representor netdev
Message-ID: <ZiaYZ7EWwauvQiBr@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-4-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:55AM CEST, gakula@marvell.com wrote:
>Adds initial devlink support to set/get the switchdev mode.
>Representor netdevs are created for each rvu devices when
>the switch mode is set to 'switchdev'. These netdevs are
>be used to control and configure VFs.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>---
> .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 154 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |   2 +
> 3 files changed, 203 insertions(+)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>index 4e1130496573..60156c7ebe45 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>@@ -76,7 +76,52 @@ static const struct devlink_param otx2_dl_params[] = {
> 			     otx2_dl_mcam_count_validate),
> };
> 
>+#ifdef CONFIG_RVU_ESWITCH
>+static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
>+	struct otx2_nic *pfvf = otx2_dl->pfvf;
>+
>+	if (!is_rep_dev(pfvf->pdev))
>+		return -EOPNOTSUPP;
>+
>+	*mode = pfvf->esw_mode;
>+
>+	return 0;
>+}
>+
>+static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>+					 struct netlink_ext_ack *extack)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
>+	struct otx2_nic *pfvf = otx2_dl->pfvf;
>+
>+	if (!is_rep_dev(pfvf->pdev))
>+		return -EOPNOTSUPP;
>+
>+	if (pfvf->esw_mode == mode)
>+		return 0;
>+
>+	switch (mode) {
>+	case DEVLINK_ESWITCH_MODE_LEGACY:
>+		rvu_rep_destroy(pfvf);
>+		break;
>+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>+		rvu_rep_create(pfvf);


rvu_rep_create() returns int. Return that from this function. Also, pass
extack and let rvu_rep_create() fill up the message in case of any
error.


>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+	pfvf->esw_mode = mode;
>+	return 0;
>+}
>+#endif
>+
> static const struct devlink_ops otx2_devlink_ops = {
>+#ifdef CONFIG_RVU_ESWITCH
>+	.eswitch_mode_get = otx2_devlink_eswitch_mode_get,
>+	.eswitch_mode_set = otx2_devlink_eswitch_mode_set,
>+#endif
> };
> 
> int otx2_register_dl(struct otx2_nic *pfvf)
>@@ -112,6 +157,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
> 	devlink_free(dl);
> 	return err;
> }
>+EXPORT_SYMBOL(otx2_register_dl);
> 
> void otx2_unregister_dl(struct otx2_nic *pfvf)
> {
>@@ -123,3 +169,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
> 				  ARRAY_SIZE(otx2_dl_params));
> 	devlink_free(dl);
> }
>+EXPORT_SYMBOL(otx2_unregister_dl);
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>index 0e19b938d197..e2571728cb0d 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>@@ -28,6 +28,154 @@ MODULE_DESCRIPTION(DRV_STRING);
> MODULE_LICENSE("GPL");
> MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> 
>+static int rvu_rep_napi_init(struct otx2_nic *priv)
>+{
>+	struct otx2_cq_poll *cq_poll = NULL;
>+	struct otx2_qset *qset = &priv->qset;
>+	struct otx2_hw *hw = &priv->hw;
>+	int err = 0, qidx, vec;
>+	char *irq_name;
>+
>+	qset->napi = kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
>+	if (!qset->napi)
>+		return -ENOMEM;
>+
>+	/* Register NAPI handler */
>+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
>+		cq_poll = &qset->napi[qidx];
>+		cq_poll->cint_idx = qidx;
>+		cq_poll->cq_ids[CQ_RX] =
>+			(qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_TX] = (qidx < hw->tx_queues) ?
>+					  qidx + hw->rx_queues : CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_XDP] = CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_QOS] = CINT_INVALID_CQ;
>+
>+		cq_poll->dev = (void *)priv;
>+		netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
>+			       otx2_napi_handler);
>+		napi_enable(&cq_poll->napi);
>+	}
>+	/* Register CQ IRQ handlers */
>+	vec = hw->nix_msixoff + NIX_LF_CINT_VEC_START;
>+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
>+		irq_name = &hw->irq_name[vec * NAME_SIZE];
>+
>+		snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx);
>+
>+		err = request_irq(pci_irq_vector(priv->pdev, vec),
>+				  otx2_cq_intr_handler, 0, irq_name,
>+				  &qset->napi[qidx]);
>+		if (err) {
>+			dev_err(priv->dev,
>+				"RVU REP IRQ registration failed for CQ%d\n", qidx);
>+			goto err_free_cints;
>+		}
>+		vec++;
>+
>+		/* Enable CQ IRQ */
>+		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
>+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0));
>+	}
>+	priv->flags &= ~OTX2_FLAG_INTF_DOWN;
>+	return 0;
>+
>+err_free_cints:
>+	otx2_free_cints(priv, qidx);
>+	otx2_disable_napi(priv);
>+	return err;
>+}
>+
>+static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv)
>+{
>+	struct otx2_cq_poll *cq_poll = NULL;
>+	struct otx2_qset *qset = &priv->qset;
>+	int qidx, vec;
>+
>+	/* Cleanup CQ NAPI and IRQ */
>+	vec = priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
>+	for (qidx = 0; qidx < priv->hw.cint_cnt; qidx++) {
>+		/* Disable interrupt */
>+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx), BIT_ULL(0));
>+
>+		synchronize_irq(pci_irq_vector(priv->pdev, vec));
>+
>+		cq_poll = &qset->napi[qidx];
>+		napi_synchronize(&cq_poll->napi);
>+		vec++;
>+	}
>+	otx2_free_cints(priv, priv->hw.cint_cnt);
>+	otx2_disable_napi(priv);
>+}
>+
>+void rvu_rep_destroy(struct otx2_nic *priv)
>+{
>+	struct rep_dev *rep;
>+	int rep_id;
>+
>+	rvu_rep_free_cq_rsrc(priv);
>+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
>+		rep = priv->reps[rep_id];
>+		unregister_netdev(rep->netdev);
>+		free_netdev(rep->netdev);
>+	}
>+}
>+
>+int rvu_rep_create(struct otx2_nic *priv)
>+{
>+	int rep_cnt = priv->rep_cnt;
>+	struct net_device *ndev;
>+	struct rep_dev *rep;
>+	int rep_id, err;
>+	u16 pcifunc;
>+
>+	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev), GFP_KERNEL);
>+	if (!priv->reps)
>+		return -ENOMEM;
>+
>+	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
>+		ndev = alloc_etherdev(sizeof(*rep));
>+		if (!ndev) {
>+			dev_err(priv->dev, "PFVF representor:%d creation failed\n", rep_id);

Please avoid dmesg prints like this, use extack instead.
Please follow this with the functions you call, like rvu_rep_napi_init()


>+			err = -ENOMEM;
>+			goto exit;
>+		}
>+
>+		rep = netdev_priv(ndev);
>+		priv->reps[rep_id] = rep;
>+		rep->mdev = priv;
>+		rep->netdev = ndev;
>+		rep->rep_id = rep_id;
>+
>+		ndev->min_mtu = OTX2_MIN_MTU;
>+		ndev->max_mtu = priv->hw.max_mtu;
>+		pcifunc = priv->rep_pf_map[rep_id];
>+		rep->pcifunc = pcifunc;
>+
>+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
>+			 rvu_get_pf(pcifunc));
>+
>+		eth_hw_addr_random(ndev);
>+		err = register_netdev(ndev);
>+		if (err) {
>+			dev_err(priv->dev, "PFVF reprentator registration failed\n");
>+			goto exit;
>+		}
>+	}
>+	err = rvu_rep_napi_init(priv);
>+	if (err)
>+		goto exit;
>+
>+	return 0;
>+exit:
>+	while (--rep_id >= 0) {
>+		rep = priv->reps[rep_id];
>+		unregister_netdev(rep->netdev);
>+		free_netdev(rep->netdev);
>+	}
>+	return err;
>+}
>+
> static int rvu_rep_rsrc_free(struct otx2_nic *priv)
> {
> 	struct otx2_qset *qset = &priv->qset;
>@@ -163,6 +311,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	if (err)
> 		goto err_detach_rsrc;
> 
>+	err = otx2_register_dl(priv);
>+	if (err)
>+		goto err_detach_rsrc;
>+
> 	return 0;
> 
> err_detach_rsrc:
>@@ -184,6 +336,8 @@ static void rvu_rep_remove(struct pci_dev *pdev)
> {
> 	struct otx2_nic *priv = pci_get_drvdata(pdev);
> 
>+	otx2_unregister_dl(priv);
>+	rvu_rep_destroy(priv);
> 	rvu_rep_rsrc_free(priv);
> 	otx2_detach_resources(&priv->mbox);
> 	if (priv->hw.lmt_info)
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>index 30cce17eb48b..be6c939e5cba 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>@@ -29,4 +29,6 @@ static inline bool is_rep_dev(struct pci_dev *pdev)
> 	return pdev->device == PCI_DEVID_RVU_REP;
> }
> 
>+int rvu_rep_create(struct otx2_nic *priv);
>+void rvu_rep_destroy(struct otx2_nic *priv);
> #endif /* REP_H */
>-- 
>2.25.1
>
>

