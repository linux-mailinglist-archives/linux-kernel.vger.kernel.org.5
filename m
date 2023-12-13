Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06A811F87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjLMTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjLMTzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:55:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8914D7F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:53:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A929AC433C7;
        Wed, 13 Dec 2023 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702497239;
        bh=dcjUy2QND46YM2W9IosA0LzvC8ULdjGPyZnZLP6Ia3I=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VMybQw20CoC5U8K+WyP5dgGTjp4Bl0IOQeA6Srubt/Kpgugo/8IwNYBD3Sigla1gj
         XaVzHYKbDNnpr5AHt1yeu70EHuOeQMW81wGzjmhy4INjCkG5mLpf6PD0+H89bPQV3B
         nPGmzsn84GT1eyIY3uNzKYgN0s13je2jVb5xNvXXoxi6Q2pxxFCCGO0fpNgREdOb3Y
         +3YcuOHHahFofUriI3VTMo1muq+Wvny0oUOapUfcQK1mucO3cwP/5yYciLvxjgbYnI
         EG+L9nx+wzwDn43j9Me34XpBY21CY4HzDz7v2aqAhb9qd4Hj+NQxY18ydU+owmXfk/
         5goU8DheuihiA==
Message-ID: <52340f6e-e253-4eef-b395-2805aeac65a9@kernel.org>
Date:   Wed, 13 Dec 2023 20:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] crypto: tegra: Add Tegra Security Engine driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org
References: <20231213122030.11734-1-akhilrajeev@nvidia.com>
 <20231213122030.11734-4-akhilrajeev@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231213122030.11734-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 13:20, Akhil R wrote:
> Add support for Tegra Security Engine which can accelerates various
> crypto algorithms. The Engine has two separate instances within for
> AES and HASH algorithms respectively.
> 
> The driver registers two crypto engines - one for AES and another for
> HASH algorithms and these operate independently and both uses the host1x
> bus. Additionally, it provides  hardware-assisted key protection for up
> to 15 symmetric keys which it can use for the cipher operations.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---

...

> +
> +int tegra_init_hash(struct tegra_se *se)
> +{
> +	struct ahash_engine_alg *alg;
> +	int i, ret;
> +
> +	se->manifest = tegra_hash_kac_manifest;
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra_hash_algs); i++) {
> +		tegra_hash_algs[i].se_dev = se;
> +		alg = &tegra_hash_algs[i].alg.ahash;
> +
> +		ret = crypto_engine_register_ahash(alg);
> +		if (ret) {
> +			dev_err(se->dev, "failed to register %s\n",
> +				alg->base.halg.base.cra_name);
> +			goto sha_err;
> +		}
> +	}
> +
> +	dev_info(se->dev, "registered HASH algorithms\n");

Drop, not needed. Actually drop simple success messages. Drivers do not
spam dmesg without need.

...

> +
> +int tegra_se_host1x_register(struct tegra_se *se)
> +{
> +	INIT_LIST_HEAD(&se->client.list);
> +	se->client.dev = se->dev;
> +	se->client.ops = &tegra_se_client_ops;
> +	se->client.class = se->hw->host1x_class;
> +	se->client.num_syncpts = 1;
> +
> +	host1x_client_register(&se->client);
> +
> +	return 0;
> +}
> +
> +static int tegra_se_clk_init(struct tegra_se *se)
> +{
> +	int i, ret;
> +
> +	se->clk = devm_clk_get(se->dev, NULL);
> +	if (IS_ERR(se->clk)) {
> +		dev_err(se->dev, "failed to get clock\n");

Why do you print failures multiple times? Once here, second in probe.

return dev_err_probe

> +		return PTR_ERR(se->clk);
> +	}
> +
> +	ret = clk_set_rate(se->clk, ULONG_MAX);
> +	if (ret) {
> +		dev_err(se->dev, "failed to set %d clock rate", i);

Same comments

> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(se->clk);
> +	if (ret) {
> +		dev_err(se->dev, "failed to enable clocks\n");

Same comments

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra_se_clk_deinit(struct tegra_se *se)
> +{
> +	clk_disable_unprepare(se->clk);

Why aren't you using devm_clk_get_enabled? This looks like porting some
old, out-of-tree vendor crappy driver :(

> +}
> +
> +static int tegra_se_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tegra_se *se;
> +	int ret;
> +
> +	se = devm_kzalloc(dev, sizeof(*se), GFP_KERNEL);
> +	if (!se)
> +		return -ENOMEM;
> +
> +	se->dev = dev;
> +	se->owner = TEGRA_GPSE_ID;
> +	se->hw = device_get_match_data(&pdev->dev);
> +
> +	se->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(se->base))
> +		return PTR_ERR(se->base);
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(39));
> +	platform_set_drvdata(pdev, se);
> +
> +	ret = tegra_se_clk_init(se);
> +	if (ret) {
> +		dev_err(dev, "failed to init clocks\n");

Syntax is:
return dev_err_probe

> +		return ret;
> +	}
> +
> +	if (!tegra_dev_iommu_get_stream_id(dev, &se->stream_id)) {
> +		dev_err(dev, "failed to get IOMMU stream ID\n");

dev_err_probe

> +		goto clk_deinit;
> +	}
> +
> +	se_writel(se, se->stream_id, SE_STREAM_ID);
> +
> +	se->engine = crypto_engine_alloc_init(dev, 0);
> +	if (!se->engine) {
> +		dev_err(dev, "failed to init crypto engine\n");

Really? Test your code with coccinelle. Drop.

> +		ret = -ENOMEM;
> +		goto iommu_free;
> +	}
> +
> +	ret = crypto_engine_start(se->engine);
> +	if (ret) {
> +		dev_err(dev, "failed to start crypto engine\n");

dev_err_probe

> +		goto engine_exit;
> +	}
> +
> +	ret = tegra_se_host1x_register(se);
> +	if (ret) {
> +		dev_err(dev, "failed to init host1x params\n");

dev_err_probe

> +		goto engine_stop;
> +	}
> +
> +	return 0;
> +
> +engine_stop:
> +	crypto_engine_stop(se->engine);
> +engine_exit:
> +	crypto_engine_exit(se->engine);
> +iommu_free:
> +	iommu_fwspec_free(se->dev);
> +clk_deinit:
> +	tegra_se_clk_deinit(se);
> +
> +	return ret;
> +}
> +
> +static int tegra_se_remove(struct platform_device *pdev)
> +{
> +	struct tegra_se *se = platform_get_drvdata(pdev);
> +
> +	crypto_engine_stop(se->engine);
> +	crypto_engine_exit(se->engine);
> +	iommu_fwspec_free(se->dev);
> +	host1x_client_unregister(&se->client);
> +	tegra_se_clk_deinit(se);
> +
> +	return 0;
> +}
> +
> +static const struct tegra_se_regs tegra234_aes1_regs = {
> +	.config = SE_AES1_CFG,
> +	.op = SE_AES1_OPERATION,
> +	.last_blk = SE_AES1_LAST_BLOCK,
> +	.linear_ctr = SE_AES1_LINEAR_CTR,
> +	.aad_len = SE_AES1_AAD_LEN,
> +	.cryp_msg_len = SE_AES1_CRYPTO_MSG_LEN,
> +	.manifest = SE_AES1_KEYMANIFEST,
> +	.key_addr = SE_AES1_KEY_ADDR,
> +	.key_data = SE_AES1_KEY_DATA,
> +	.key_dst = SE_AES1_KEY_DST,
> +	.result = SE_AES1_CMAC_RESULT,
> +};
> +
> +static const struct tegra_se_regs tegra234_hash_regs = {
> +	.config = SE_SHA_CFG,
> +	.op = SE_SHA_OPERATION,
> +	.manifest = SE_SHA_KEYMANIFEST,
> +	.key_addr = SE_SHA_KEY_ADDR,
> +	.key_data = SE_SHA_KEY_DATA,
> +	.key_dst = SE_SHA_KEY_DST,
> +	.result = SE_SHA_HASH_RESULT,
> +};
> +
> +static const struct tegra_se_hw tegra234_aes_hw = {
> +	.regs = &tegra234_aes1_regs,
> +	.kac_ver = 1,
> +	.host1x_class = 0x3b,
> +	.init_alg = tegra_init_aes,
> +	.deinit_alg = tegra_deinit_aes,
> +};
> +
> +static const struct tegra_se_hw tegra234_hash_hw = {
> +	.regs = &tegra234_hash_regs,
> +	.kac_ver = 1,
> +	.host1x_class = 0x3d,
> +	.init_alg = tegra_init_hash,
> +	.deinit_alg = tegra_deinit_hash,
> +};
> +
> +static const struct of_device_id tegra_se_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra234-se2-aes",
> +		.data = &tegra234_aes_hw
> +	}, {
> +		.compatible = "nvidia,tegra234-se4-hash",
> +		.data = &tegra234_hash_hw,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tegra_se_of_match);
> +
> +static struct platform_driver tegra_se_driver = {
> +	.driver = {
> +		.name	= "tegra-se",
> +		.of_match_table = tegra_se_of_match,
> +	},
> +	.probe		= tegra_se_probe,
> +	.remove		= tegra_se_remove,
> +};
> +
> +static int tegra_se_host1x_probe(struct host1x_device *dev)
> +{
> +	return host1x_device_init(dev);
> +}
> +
> +static int tegra_se_host1x_remove(struct host1x_device *dev)
> +{
> +	host1x_device_exit(dev);
> +
> +	return 0;
> +}
> +


...

> +		return -EINVAL;
> +}
> +
> +/* Functions */
> +int tegra_init_aead(struct tegra_se *se);

I look for it and cannot find it... Drop.

> +int tegra_init_aes(struct tegra_se *se);
> +int tegra_init_hash(struct tegra_se *se);
> +void tegra_deinit_aes(struct tegra_se *se);
> +void tegra_deinit_hash(struct tegra_se *se);
> +
> +int tegra_key_submit(struct tegra_se *se, const u8 *key, u32 keylen, u32 alg, u32 *keyid);
> +unsigned int tegra_key_get_idx(struct tegra_se *se, u32 keyid);
> +void tegra_key_invalidate(struct tegra_se *se, u32 keyid, u32 alg);
> +
> +int tegra_se_host1x_register(struct tegra_se *se);
> +int tegra_se_host1x_submit(struct tegra_se *se, u32 size);

Everything looks bogus...

> +
> +static inline void se_writel(struct tegra_se *se, u32 val,
> +			     unsigned int offset)
> +{
> +	writel_relaxed(val, se->base + offset);
> +}
> +
> +static inline u32 se_readl(struct tegra_se *se, unsigned int offset)
> +{
> +	return readl_relaxed(se->base + offset);
> +}

Both wrappers are useless.

> +
> +/****
> + *

Use Linux coding style comments.

> + * HOST1x OPCODES
> + *
> + ****/
> +

...

> +
> +static inline u32 host1x_opcode_nonincr(unsigned int offset, unsigned int count)
> +{
> +	return (2 << 28) | (offset << 16) | count;
> +}
> +
> +static inline u32 host1x_uclass_incr_syncpt_cond_f(u32 v)
> +{
> +		return (v & 0xff) << 10;

Fix indentation, in other places as well.


Best regards,
Krzysztof

