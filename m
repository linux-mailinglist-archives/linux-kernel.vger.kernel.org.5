Return-Path: <linux-kernel+bounces-81019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15296866F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3947D1C24B77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F685C7C;
	Mon, 26 Feb 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEkyWpAe"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690585296
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938810; cv=none; b=gUAm1TpT2n+0Bk4SsPEQwgCMUhmxJYdfPBSakYSCbu0X01npfbGTZeqNYszaBO0NWIdlOMzqF95CGWYITMnyQn0s/wQzpW6K2wgkXTsqGiS5nErLxLpiZjmere/2o5WNWpTrx2NcX9C6Y8atE5PFMeZV++ce3irS7CBEeEvIhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938810; c=relaxed/simple;
	bh=QbANRChfEsLlRShvnymeKAkc2TXGDF3qZnv/aAw/lt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bNEniGx4lHAt5TawU2l/OgymJJNz9y8YxnXuyfks6l6JfRB7r6T4Z1/eag7S07EG03ibH3rYdjoj5pFVSjy6sm5MRFndAyCGQD4Vb/UqLlg1mxuX32P+EjbD+aVi/jN+R4YQq7gpDPAbCRwlvDInK/fBA3eC1JCEvDVW7ch5zRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEkyWpAe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bce554a5so3467924e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938806; x=1709543606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLR1nF0u3m/pNXvlylaKQvnEVsgTQRO3IAjTH1HLyfw=;
        b=sEkyWpAeDQOZQR6nN/M7xF9xlp0MWjkzpNQQyuOSm4cWUhBSSPAkbrp2pAIyc9XGNe
         O3sbGhdEPSbBmEuCty/15w0gbaSwVOxlH2ihGxkvhc6zFT/mcOQ+4y5mx4MWFwp6Zxbd
         BDiRRz6YRnnNh5N5CA1GQ5ogy9Xs4ikQXkef7Eo4hhjG2nOnOiiZo1TBEZHDgZucsCR6
         +t0yJ7X+iP5/Mn4MCKmNLtdismu/rtCG0e9t7vq5KdaHejM5IUCVos/nj5Gtqq5Ca0OV
         xAod0XWGtzuxzompIC4B5tpfpNjy0j2hzN4J9a/iEDsBgkhLIZXoZSm2rn44C7g75Kls
         UaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938806; x=1709543606;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLR1nF0u3m/pNXvlylaKQvnEVsgTQRO3IAjTH1HLyfw=;
        b=XVel5uEai6gpUVF9FKRZA0guhjSd2yt1gplXkWtCV/uWU5SLWsdHGRUf0WAoQAxIbE
         Fxqty/gaszDND6g5rfYDn2mmYAyxqkLjjgT+DfaEr4e5FFjD0zFFYkFpW8hioX8Sjn5p
         Mk8Uxx9xORKLhRpWI6L2XYfgzEfAjzCZGA5Chi+tktqQBbnNnPngoeTJXTU2Dn5guqPO
         Jf9FEfDLKYvcLMDGayWcy69tv4DOghUxwcjkDq8nN2LFRwQMH7qjB/lm/bQ4G8vqWhaw
         rDlbzgDQaJ+TED7t3lh+y5KexrpUOM7nbvnxDorQZCGE7U8aMOhRFgjIYrHWdnv/U+oT
         3Xmw==
X-Forwarded-Encrypted: i=1; AJvYcCUqrWW5sUhftnCaf9UV+Zn2YRwNIXo8iBPgm7iaW0wxVFDIPwijKt51dTB5JvERE+VpsZwkxIjGuvXDdzgnK4Beuo9cET79pc33CfVo
X-Gm-Message-State: AOJu0YwZ4iITlVI7I6E7MHwNO+kt+DcTrfW/fs5RPwTH8s7cRFU/5yJL
	DeaN/Z8uLwsnUJSz9jaWqqWPdwS9aBZMeA97+KHpQAOGG/nUN7y/M7imQ04jFT4=
X-Google-Smtp-Source: AGHT+IFzkpKEy758/uKgT+OoHpp+sYhJU6lmcs5xoEid5uQRGgRW7kbOrz6EGxUCtJtLuE7J5fYh7Q==
X-Received: by 2002:a19:5e19:0:b0:512:b27c:18b5 with SMTP id s25-20020a195e19000000b00512b27c18b5mr3776613lfb.30.1708938806264;
        Mon, 26 Feb 2024 01:13:26 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r15-20020adfce8f000000b0033db2d6bf83sm7550422wrn.34.2024.02.26.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:13:26 -0800 (PST)
Date: Mon, 26 Feb 2024 12:13:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Message-ID: <8af83663-e7d9-4a18-833f-a32df97b96e7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v1-1-e0ad972cda99@outlook.com>

Hi Yang,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/net-hisilicon-add-support-for-hisi_femac-core-on-Hi3798MV200/20240216-075015
base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
patch link:    https://lore.kernel.org/r/20240216-net-v1-1-e0ad972cda99%40outlook.com
patch subject: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on Hi3798MV200
config: arm-randconfig-r081-20240223 (https://download.01.org/0day-ci/archive/20240224/202402242354.leEII4M9-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402242354.leEII4M9-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/hisilicon/hisi_femac.c:931 hisi_femac_drv_probe() error: uninitialized symbol 'ret'.

vim +/ret +931 drivers/net/ethernet/hisilicon/hisi_femac.c

542ae60af24f02 Dongpo Li      2016-07-15  786  static int hisi_femac_drv_probe(struct platform_device *pdev)
542ae60af24f02 Dongpo Li      2016-07-15  787  {
542ae60af24f02 Dongpo Li      2016-07-15  788  	struct device *dev = &pdev->dev;
3c2c758a1607ea Yang Xiwen     2024-02-16  789  	struct device_node *node = dev->of_node, *mdio_np;
542ae60af24f02 Dongpo Li      2016-07-15  790  	struct net_device *ndev;
542ae60af24f02 Dongpo Li      2016-07-15  791  	struct hisi_femac_priv *priv;
542ae60af24f02 Dongpo Li      2016-07-15  792  	struct phy_device *phy;
3c2c758a1607ea Yang Xiwen     2024-02-16  793  	int ret, i;
3c2c758a1607ea Yang Xiwen     2024-02-16  794  	bool mdio_registered = false;
3c2c758a1607ea Yang Xiwen     2024-02-16  795  	static const char * const clk_strs[] = {
3c2c758a1607ea Yang Xiwen     2024-02-16  796  		[CLK_MAC] = "mac",
3c2c758a1607ea Yang Xiwen     2024-02-16  797  		[CLK_BUS] = "bus",
3c2c758a1607ea Yang Xiwen     2024-02-16  798  		[CLK_PHY] = "phy",
3c2c758a1607ea Yang Xiwen     2024-02-16  799  	};
542ae60af24f02 Dongpo Li      2016-07-15  800  
542ae60af24f02 Dongpo Li      2016-07-15  801  	ndev = alloc_etherdev(sizeof(*priv));
542ae60af24f02 Dongpo Li      2016-07-15  802  	if (!ndev)
542ae60af24f02 Dongpo Li      2016-07-15  803  		return -ENOMEM;
542ae60af24f02 Dongpo Li      2016-07-15  804  
542ae60af24f02 Dongpo Li      2016-07-15  805  	platform_set_drvdata(pdev, ndev);
2087d421a5a1af Dongpo Li      2016-12-12  806  	SET_NETDEV_DEV(ndev, &pdev->dev);
542ae60af24f02 Dongpo Li      2016-07-15  807  
542ae60af24f02 Dongpo Li      2016-07-15  808  	priv = netdev_priv(ndev);
542ae60af24f02 Dongpo Li      2016-07-15  809  	priv->dev = dev;
542ae60af24f02 Dongpo Li      2016-07-15  810  	priv->ndev = ndev;
542ae60af24f02 Dongpo Li      2016-07-15  811  
56170ba3bd9098 Jiangfeng Xiao 2019-07-12  812  	priv->port_base = devm_platform_ioremap_resource(pdev, 0);
542ae60af24f02 Dongpo Li      2016-07-15  813  	if (IS_ERR(priv->port_base)) {
542ae60af24f02 Dongpo Li      2016-07-15  814  		ret = PTR_ERR(priv->port_base);
542ae60af24f02 Dongpo Li      2016-07-15  815  		goto out_free_netdev;
542ae60af24f02 Dongpo Li      2016-07-15  816  	}
542ae60af24f02 Dongpo Li      2016-07-15  817  
56170ba3bd9098 Jiangfeng Xiao 2019-07-12  818  	priv->glb_base = devm_platform_ioremap_resource(pdev, 1);
542ae60af24f02 Dongpo Li      2016-07-15  819  	if (IS_ERR(priv->glb_base)) {
542ae60af24f02 Dongpo Li      2016-07-15  820  		ret = PTR_ERR(priv->glb_base);
542ae60af24f02 Dongpo Li      2016-07-15  821  		goto out_free_netdev;
542ae60af24f02 Dongpo Li      2016-07-15  822  	}
542ae60af24f02 Dongpo Li      2016-07-15  823  
3c2c758a1607ea Yang Xiwen     2024-02-16  824  	for (i = 0; i < CLK_NUM; i++) {
3c2c758a1607ea Yang Xiwen     2024-02-16  825  		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
3c2c758a1607ea Yang Xiwen     2024-02-16  826  		if (IS_ERR(priv->clks[i])) {
3c2c758a1607ea Yang Xiwen     2024-02-16  827  			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
3c2c758a1607ea Yang Xiwen     2024-02-16  828  				PTR_ERR(priv->clks[i]));
542ae60af24f02 Dongpo Li      2016-07-15  829  			ret = -ENODEV;
542ae60af24f02 Dongpo Li      2016-07-15  830  			goto out_free_netdev;
542ae60af24f02 Dongpo Li      2016-07-15  831  		}
542ae60af24f02 Dongpo Li      2016-07-15  832  	}
542ae60af24f02 Dongpo Li      2016-07-15  833  
542ae60af24f02 Dongpo Li      2016-07-15  834  	priv->mac_rst = devm_reset_control_get(dev, "mac");
542ae60af24f02 Dongpo Li      2016-07-15  835  	if (IS_ERR(priv->mac_rst)) {
542ae60af24f02 Dongpo Li      2016-07-15  836  		ret = PTR_ERR(priv->mac_rst);
3c2c758a1607ea Yang Xiwen     2024-02-16  837  		goto out_free_netdev;
542ae60af24f02 Dongpo Li      2016-07-15  838  	}
542ae60af24f02 Dongpo Li      2016-07-15  839  	hisi_femac_core_reset(priv);
542ae60af24f02 Dongpo Li      2016-07-15  840  
542ae60af24f02 Dongpo Li      2016-07-15  841  	priv->phy_rst = devm_reset_control_get(dev, "phy");
542ae60af24f02 Dongpo Li      2016-07-15  842  	if (IS_ERR(priv->phy_rst)) {
542ae60af24f02 Dongpo Li      2016-07-15  843  		priv->phy_rst = NULL;
542ae60af24f02 Dongpo Li      2016-07-15  844  	} else {
542ae60af24f02 Dongpo Li      2016-07-15  845  		ret = of_property_read_u32_array(node,
542ae60af24f02 Dongpo Li      2016-07-15  846  						 PHY_RESET_DELAYS_PROPERTY,
542ae60af24f02 Dongpo Li      2016-07-15  847  						 priv->phy_reset_delays,
542ae60af24f02 Dongpo Li      2016-07-15  848  						 DELAYS_NUM);
542ae60af24f02 Dongpo Li      2016-07-15  849  		if (ret)
3c2c758a1607ea Yang Xiwen     2024-02-16  850  			goto out_free_netdev;
542ae60af24f02 Dongpo Li      2016-07-15  851  		hisi_femac_phy_reset(priv);
542ae60af24f02 Dongpo Li      2016-07-15  852  	}
542ae60af24f02 Dongpo Li      2016-07-15  853  
3c2c758a1607ea Yang Xiwen     2024-02-16  854  	// Register the optional MDIO bus
3c2c758a1607ea Yang Xiwen     2024-02-16  855  	for_each_available_child_of_node(node, mdio_np) {
3c2c758a1607ea Yang Xiwen     2024-02-16  856  		if (of_node_name_prefix(mdio_np, "mdio")) {
3c2c758a1607ea Yang Xiwen     2024-02-16  857  			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
3c2c758a1607ea Yang Xiwen     2024-02-16  858  			of_node_put(mdio_np);
3c2c758a1607ea Yang Xiwen     2024-02-16  859  			if (!priv->mdio_pdev) {
3c2c758a1607ea Yang Xiwen     2024-02-16  860  				dev_err(dev, "failed to register MDIO bus device\n");

ret = -ENOMEM;

3c2c758a1607ea Yang Xiwen     2024-02-16  861  				goto out_free_netdev;
3c2c758a1607ea Yang Xiwen     2024-02-16  862  			}
3c2c758a1607ea Yang Xiwen     2024-02-16  863  			mdio_registered = true;
3c2c758a1607ea Yang Xiwen     2024-02-16  864  			break;
3c2c758a1607ea Yang Xiwen     2024-02-16  865  		}
3c2c758a1607ea Yang Xiwen     2024-02-16  866  	}
3c2c758a1607ea Yang Xiwen     2024-02-16  867  
3c2c758a1607ea Yang Xiwen     2024-02-16  868  	if (!mdio_registered)
3c2c758a1607ea Yang Xiwen     2024-02-16  869  		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
3c2c758a1607ea Yang Xiwen     2024-02-16  870  
542ae60af24f02 Dongpo Li      2016-07-15  871  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
542ae60af24f02 Dongpo Li      2016-07-15  872  	if (!phy) {
542ae60af24f02 Dongpo Li      2016-07-15  873  		dev_err(dev, "connect to PHY failed!\n");
542ae60af24f02 Dongpo Li      2016-07-15  874  		ret = -ENODEV;
3c2c758a1607ea Yang Xiwen     2024-02-16  875  		goto out_unregister_mdio_bus;
542ae60af24f02 Dongpo Li      2016-07-15  876  	}
542ae60af24f02 Dongpo Li      2016-07-15  877  
542ae60af24f02 Dongpo Li      2016-07-15  878  	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
542ae60af24f02 Dongpo Li      2016-07-15  879  			   (unsigned long)phy->phy_id,
542ae60af24f02 Dongpo Li      2016-07-15  880  			   phy_modes(phy->interface));
542ae60af24f02 Dongpo Li      2016-07-15  881  
9ca01b25dffffe Jakub Kicinski 2021-10-06  882  	ret = of_get_ethdev_address(node, ndev);
83216e3988cd19 Michael Walle  2021-04-12  883  	if (ret) {
542ae60af24f02 Dongpo Li      2016-07-15  884  		eth_hw_addr_random(ndev);
542ae60af24f02 Dongpo Li      2016-07-15  885  		dev_warn(dev, "using random MAC address %pM\n",
542ae60af24f02 Dongpo Li      2016-07-15  886  			 ndev->dev_addr);
542ae60af24f02 Dongpo Li      2016-07-15  887  	}
542ae60af24f02 Dongpo Li      2016-07-15  888  
542ae60af24f02 Dongpo Li      2016-07-15  889  	ndev->watchdog_timeo = 6 * HZ;
542ae60af24f02 Dongpo Li      2016-07-15  890  	ndev->priv_flags |= IFF_UNICAST_FLT;
542ae60af24f02 Dongpo Li      2016-07-15  891  	ndev->netdev_ops = &hisi_femac_netdev_ops;
542ae60af24f02 Dongpo Li      2016-07-15  892  	ndev->ethtool_ops = &hisi_femac_ethtools_ops;
b707b89f7be361 Jakub Kicinski 2022-05-06  893  	netif_napi_add_weight(ndev, &priv->napi, hisi_femac_poll,
b707b89f7be361 Jakub Kicinski 2022-05-06  894  			      FEMAC_POLL_WEIGHT);
542ae60af24f02 Dongpo Li      2016-07-15  895  
542ae60af24f02 Dongpo Li      2016-07-15  896  	hisi_femac_port_init(priv);
542ae60af24f02 Dongpo Li      2016-07-15  897  
542ae60af24f02 Dongpo Li      2016-07-15  898  	ret = hisi_femac_init_tx_and_rx_queues(priv);
542ae60af24f02 Dongpo Li      2016-07-15  899  	if (ret)
542ae60af24f02 Dongpo Li      2016-07-15  900  		goto out_disconnect_phy;
542ae60af24f02 Dongpo Li      2016-07-15  901  
542ae60af24f02 Dongpo Li      2016-07-15  902  	ndev->irq = platform_get_irq(pdev, 0);
ae1d60c41e581b Ruan Jinjie    2023-07-31  903  	if (ndev->irq < 0) {
ae1d60c41e581b Ruan Jinjie    2023-07-31  904  		ret = ndev->irq;
542ae60af24f02 Dongpo Li      2016-07-15  905  		goto out_disconnect_phy;
542ae60af24f02 Dongpo Li      2016-07-15  906  	}
542ae60af24f02 Dongpo Li      2016-07-15  907  
542ae60af24f02 Dongpo Li      2016-07-15  908  	ret = devm_request_irq(dev, ndev->irq, hisi_femac_interrupt,
542ae60af24f02 Dongpo Li      2016-07-15  909  			       IRQF_SHARED, pdev->name, ndev);
542ae60af24f02 Dongpo Li      2016-07-15  910  	if (ret) {
542ae60af24f02 Dongpo Li      2016-07-15  911  		dev_err(dev, "devm_request_irq %d failed!\n", ndev->irq);
542ae60af24f02 Dongpo Li      2016-07-15  912  		goto out_disconnect_phy;
542ae60af24f02 Dongpo Li      2016-07-15  913  	}
542ae60af24f02 Dongpo Li      2016-07-15  914  
542ae60af24f02 Dongpo Li      2016-07-15  915  	ret = register_netdev(ndev);
542ae60af24f02 Dongpo Li      2016-07-15  916  	if (ret) {
542ae60af24f02 Dongpo Li      2016-07-15  917  		dev_err(dev, "register_netdev failed!\n");
542ae60af24f02 Dongpo Li      2016-07-15  918  		goto out_disconnect_phy;
542ae60af24f02 Dongpo Li      2016-07-15  919  	}
542ae60af24f02 Dongpo Li      2016-07-15  920  
542ae60af24f02 Dongpo Li      2016-07-15  921  	return ret;
542ae60af24f02 Dongpo Li      2016-07-15  922  
542ae60af24f02 Dongpo Li      2016-07-15  923  out_disconnect_phy:
542ae60af24f02 Dongpo Li      2016-07-15  924  	netif_napi_del(&priv->napi);
542ae60af24f02 Dongpo Li      2016-07-15  925  	phy_disconnect(phy);
3c2c758a1607ea Yang Xiwen     2024-02-16  926  out_unregister_mdio_bus:
3c2c758a1607ea Yang Xiwen     2024-02-16  927  	platform_device_unregister(priv->mdio_pdev);
542ae60af24f02 Dongpo Li      2016-07-15  928  out_free_netdev:
542ae60af24f02 Dongpo Li      2016-07-15  929  	free_netdev(ndev);
542ae60af24f02 Dongpo Li      2016-07-15  930  
542ae60af24f02 Dongpo Li      2016-07-15 @931  	return ret;
542ae60af24f02 Dongpo Li      2016-07-15  932  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


