Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E231476DFC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjHCFgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjHCFgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:36:08 -0400
X-Greylist: delayed 1174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 22:36:04 PDT
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547E1FED;
        Wed,  2 Aug 2023 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7SF+07K71ohh0WDQNef5po3x/ysEktiM4oUVhWKFpQ4=;
        t=1691040964;x=1691130964; 
        b=IoSaAmYwDYqTma0igUaJoXi7HU25oG9p05/y54zQpPUfCpCW6v149/nARVg7DS7HUvenHmglDSv4qJL+9r+FFkcuJqCTPR/u8uC0LKgejSt8/5G62zGVVA0G8+W3Pw3k+0WWv0JX9NdVUqGip+m8JMTjZykk9OkhpbgIgibl6S7cN3rbcMBiYMk8nYfl6A9ivVmBAKzykAGarz7clE+dk1rsZwGCt5S+exXujD1ibxIqP7x5e+4zPGXHvUQiGXW0VsTWf2oBTywzjgSg3vz9UXARSlr6fmJ2SYYkybYOzuudhhfJMQfFOoGtQ39FDl/Y0TTRGD3Yd2HhsZP5F9/Bag==;
Received: from [10.161.100.15] (port=53550 helo=smtpng3.i.mail.ru)
        by fallback2.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qRQhI-00Evkq-EK; Thu, 03 Aug 2023 08:16:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7SF+07K71ohh0WDQNef5po3x/ysEktiM4oUVhWKFpQ4=;
        t=1691039788;x=1691129788; 
        b=dXctxmEaminvxcd2Adh1TLyGHpAVFhCt7B4AZzGR80knWDAVyhkK5T/DXGm7KDIMZkfS0oX0EUjD3t5xxRQh/1gkVrD0YorcDnxy25Ovklhf+QYewNs8rq9zzVzqaOOxCO1nicOe3AVfdxtr3d2W/Fh9Ql60bhbIohZedvanyIRW1QZyUlW04fRtnx+mpdf/6ZC0NU8D4EtrYdvtDM+OV4+LYu0OwNepmmzp7iYJdKTXS8Jiem50+ww3216291w5NekO+USUbmG8qhxYkU22boiYCFGN/esbLp3IaStUFyytcp8VL6Uj4sncmEoTbn29PrF495HXNHTcMuCf49UsHQ==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qRQgx-0003YR-Rj; Thu, 03 Aug 2023 08:16:09 +0300
Message-ID: <fdd771cc-9354-208b-e8be-50d2ec6a40c9@inbox.ru>
Date:   Thu, 3 Aug 2023 08:16:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/5] ASoC: dwc: i2s: Add StarFive JH7110 SoC support
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-4-xingyu.wu@starfivetech.com>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20230802084301.134122-4-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD93761F2630DFFAF419FF9F36511838303579425D3053CF375182A05F538085040A43AEB9EE471BF590BA4D0903507B565CF94DF8359E0D3D1F5C007C0E5B44D8E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BBC4AF2A01A27A06EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371E4BC0E00C009995EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA926EDEA9C8C4A220F6A49BED6FC8378E20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C091DAD9F922AA71188941B15DA834481FA18204E546F3947C7AE820D2C17D0E56F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637990DCC27F6719F98389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E73557739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A568B3C69D00CF7EA59AFF425838D6083DF6F5AD3B11D1C70CF87CCE6106E1FC07E67D4AC08A07B9B0AD0E433DBF1FBFA3CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF047F6813025EDDE9D08033DDC88F3ED78B8B6229CDE5AA3EA12E2341A1FE79787D7FE2FA29F577878553022043D0BC9A5D4881C73C9D659B10E80BB90F46987DE4EB81C25D25832B4C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojcir52QaMQ83GZmVOKMR6Fw==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BABA8A15A10676D7D60F49567370C77E298CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C3F491B0628B0BA637FE5AC1F9A8BDE1825B1EE4FB3A289B68F3CF0E9FE49B69C726D56F050CBF74C51CC38A3738A5A8CD5DB17EA4F3012617D41A280E1B57D6
X-7FA49CB5: 0D63561A33F958A5A062328C449E7600B9A93EF24412079A2508D50689E0FEBACACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd3RriuhA+6EbgBCTS7VK1NQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.08.2023 11:42, Xingyu Wu wrote:

> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index c076090a9864..4dfbd8ddbcf5 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -16,6 +16,7 @@
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
> @@ -198,7 +199,7 @@ static void i2s_start(struct dw_i2s_dev *dev,
>   	else
>   		i2s_write_reg(dev->i2s_base, IRER, 1);
>   
> -	if (dev->use_pio)
> +	if (dev->use_pio || dev->is_jh7110)
>   		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
>   	else
>   		i2s_enable_dma(dev, substream->stream);
> @@ -216,7 +217,7 @@ static void i2s_stop(struct dw_i2s_dev *dev,
>   	else
>   		i2s_write_reg(dev->i2s_base, IRER, 0);
>   
> -	if (dev->use_pio)
> +	if (dev->use_pio || dev->is_jh7110)
>   		i2s_disable_irqs(dev, substream->stream, 8);
>   	else
>   		i2s_disable_dma(dev, substream->stream);

Why do we need to enable interrupts for DMA mode?

> @@ -227,6 +228,21 @@ static void i2s_stop(struct dw_i2s_dev *dev,
>   	}
>   }
>   
> +static int dw_i2s_startup(struct snd_pcm_substream *substream,
> +			  struct snd_soc_dai *cpu_dai)
> +{
> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	if (dev->is_jh7110) {
> +		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +		struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +
> +		dai_link->trigger_stop = SND_SOC_TRIGGER_ORDER_LDC;
> +	}
> +
> +	return 0;
> +}
> +
>   static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
>   {
>   	u32 ch_reg;
> @@ -267,6 +283,11 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
>   		config->data_width = 16;
>   		dev->ccr = 0x00;
>   		dev->xfer_resolution = 0x02;
> +		/* Set DMA buswidth on JH7110 */
> +		if (dev->is_jh7110) {
> +			dev->play_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +			dev->capture_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +		}

Not needed.
See: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230802&id=6f80197f40515853814d0f22e5209d53f899ab91
Proper bus width calculations is performed by 
snd_hwparams_to_dma_slave_config()

>   		break;
>   
>   	case SNDRV_PCM_FORMAT_S24_LE:
> @@ -279,6 +300,11 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
>   		config->data_width = 32;
>   		dev->ccr = 0x10;
>   		dev->xfer_resolution = 0x05;
> +		/* Set DMA buswidth on JH7110 */
> +		if (dev->is_jh7110) {
> +			dev->play_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dev->capture_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		}

Not needed.

