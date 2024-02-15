Return-Path: <linux-kernel+bounces-66480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11254855D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BD81C219AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BB1756B;
	Thu, 15 Feb 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlUKT8CN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8213FE0;
	Thu, 15 Feb 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987596; cv=none; b=ZQx+BaG45zhJ4opiVlpYazcLbDbTsPwcpvONnFR99S0SjG0+0JQ0emoWL/YUOz4Crc9/OTcvwP51i+90zpZ0nzVZyfoMq0CBGta7//40yIhvj+r6ta2fysX2R7+xXcfuMKSe4GGkjYLxMUMmg47aH/VcZ89NsIBn4TMGMO/vyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987596; c=relaxed/simple;
	bh=G9qyRbqkA8rWsZ26DMdDBi4+x1C3kmyUp9YqerlCj0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAfIr39DBb4PfM5J/d57cY8Jx+CW9h0Eu8yP9t2aWmU0LhD5H2w5yhSAXa8lXQ185PcU1tHXYM1gVBlR9G+xWFnWR3uBBADUoYzN0h/p1HfIjz2PILmKbAkTlX8mWxkHZImG8HZpPswrze0g6B54AaDq/sEca3BmG93Fo65BfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlUKT8CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDAEC433F1;
	Thu, 15 Feb 2024 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707987595;
	bh=G9qyRbqkA8rWsZ26DMdDBi4+x1C3kmyUp9YqerlCj0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jlUKT8CNq1f0gonoEAR5qIVXuHM56JANNrmeW5KovGqqvtwGSiNlMoO0cTCLl7GR8
	 +oL+TMt5lEhCJbnIX9dptE+EErldu1hg4pOquky6nVwIntF57AlCy38Y4DMDxmu8qs
	 xMslk0934/V+eewWNDhyyfz9k1Q2Aiw02xkfkRKefXolhyq5DUedXlz8EAf+UpSUrF
	 9qzaVrhvWgIgiTMIqiDXtJtk3iwPdFM677GVa14N2JxnoDHZjukijuDOxjjpo8URDc
	 mOwXLKsT18bxhcuKaXxw4AByUVRoEW9Fb73KmIFySk4tosGJBQ80uKZEDjs7cD3lfp
	 umznrBnUA/Sew==
Message-ID: <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
Date: Thu, 15 Feb 2024 09:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tee: tstee: Add Trusted Services TEE driver
Content-Language: en-US
To: Balint Dobszay <balint.dobszay@arm.com>,
 op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org, sumit.garg@linaro.org, corbet@lwn.net,
 sudeep.holla@arm.com, gyorgy.szing@arm.com
References: <20240213145239.379875-1-balint.dobszay@arm.com>
 <20240213145239.379875-3-balint.dobszay@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240213145239.379875-3-balint.dobszay@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 15:52, Balint Dobszay wrote:
> The Trusted Services project provides a framework for developing and
> deploying device Root of Trust services in FF-A Secure Partitions. The
> FF-A SPs are accessible through the FF-A driver, but this doesn't
> provide a user space interface. The goal of this TEE driver is to make
> Trusted Services SPs accessible for user space clients.
> 
> All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
> by TS. A TS SP can host one or more services, a service is identified by
> its service UUID. The same type of service cannot be present twice in
> the same SP. During SP boot each service in an SP is assigned an
> interface ID, this is just a short ID to simplify message addressing.
> There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TEE
> device is registered for each TS SP. This is required since contrary to
> the generic TEE design where memory is shared with the whole TEE
> implementation, in case of FF-A, memory is shared with a specific SP. A
> user space client has to be able to separately share memory with each SP
> based on its endpoint ID.
> 
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---


> +static int tstee_probe(struct ffa_device *ffa_dev)
> +{
> +	struct tstee *tstee;
> +	int rc;
> +
> +	ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> +
> +	if (!tstee_check_rpc_compatible(ffa_dev))
> +		return -EINVAL;
> +
> +	tstee = kzalloc(sizeof(*tstee), GFP_KERNEL);
> +	if (!tstee)
> +		return -ENOMEM;
> +
> +	tstee->ffa_dev = ffa_dev;
> +
> +	tstee->pool = tstee_create_shm_pool();
> +	if (IS_ERR(tstee->pool)) {
> +		rc = PTR_ERR(tstee->pool);
> +		tstee->pool = NULL;
> +		goto err;

Is it logically correct to call here tee_device_unregister()?

> +	}
> +
> +	tstee->teedev = tee_device_alloc(&tstee_desc, NULL, tstee->pool, tstee);
> +	if (IS_ERR(tstee->teedev)) {
> +		rc = PTR_ERR(tstee->teedev);
> +		tstee->teedev = NULL;
> +		goto err;
> +	}
> +
> +	rc = tee_device_register(tstee->teedev);
> +	if (rc)
> +		goto err;
> +
> +	ffa_dev_set_drvdata(ffa_dev, tstee);
> +
> +	pr_info("driver initialized for endpoint 0x%x\n", ffa_dev->vm_id);

Don't print simple probe success messages. Anyway all prints in device
context should be dev_*.

> +
> +	return 0;
> +
> +err:
> +	tstee_deinit_common(tstee);
> +	return rc;
> +}
> +
> +static void tstee_remove(struct ffa_device *ffa_dev)
> +{
> +	tstee_deinit_common(ffa_dev->dev.driver_data);
> +}
> +
> +static const struct ffa_device_id tstee_device_ids[] = {
> +	/* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
> +	{ TS_RPC_UUID },
> +	{}
> +};
> +
> +static struct ffa_driver tstee_driver = {
> +	.name = "arm_tstee",
> +	.probe = tstee_probe,
> +	.remove = tstee_remove,
> +	.id_table = tstee_device_ids,
> +};
> +
> +static int __init mod_init(void)
> +{
> +	return ffa_register(&tstee_driver);
> +}
> +module_init(mod_init)
> +
> +static void __exit mod_exit(void)
> +{
> +	ffa_unregister(&tstee_driver);
> +}
> +module_exit(mod_exit)
> +
> +MODULE_ALIAS("arm-tstee");

Why do you need this alias? I don't see MODULE_DEVICE_TABLE, so how this
bus handles module loading?


Best regards,
Krzysztof


