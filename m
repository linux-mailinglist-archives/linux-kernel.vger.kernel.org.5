Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF279DCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjILXj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjILXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:39:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1210C7;
        Tue, 12 Sep 2023 16:39:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMOqxc018717;
        Tue, 12 Sep 2023 23:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=id5fkwX1xUR05iSYtflHshuQq5taYP+NgXIA2zOPgFg=;
 b=jgohXBMz8OiS5vWEWOYGsXTTwv9eGDzDu/YH+TdSFP33UkabYAnI8p5aC29tFpP1raGK
 nmxbGLs58Yh29HY1ACwm45OSzXWjV3sEPuaKiZwikYPoc3NUXSYnNJBUVyHKvU4bAy1R
 s+KgnDjVqWusl006tKeajc041Ft436d1IFsr9BDlgtU4OX0eBLyH0vFpBRboCN3CbLOO
 K39cJlS8iJ7ubeVbesxWaEIg+FRB880dzXlOfoupl/Yi1WKntktucCgj9LZ77Pvw48ez
 CWFRrdn3nsdL9zuAlM38XHt0qI5n5hwvekyFPCj3k+PK0h695cPUyxFd2vhRO2U2jk6D +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7u88sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 23:39:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CNd7Tv005190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 23:39:07 GMT
Received: from [10.110.43.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 16:39:07 -0700
Message-ID: <90e27f2b-4512-6121-c5f4-e7cb87b259ab@quicinc.com>
Date:   Tue, 12 Sep 2023 16:39:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230912041904.30721-1-stanley_chang@realtek.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230912041904.30721-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vw9KNQUwb_hAf9JvdlZgqZtEc11UHoIT
X-Proofpoint-ORIG-GUID: Vw9KNQUwb_hAf9JvdlZgqZtEc11UHoIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_22,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/11/2023 9:19 PM, Stanley Chang wrote:
> In Synopsys's dwc3 data book:
> To avoid underrun and overrun during the burst, in a high-latency bus
> system (like USB), threshold and burst size control is provided through
> GTXTHRCFG and GRXTHRCFG registers.
> 
> In Realtek DHC SoC, DWC3 USB 3.0 uses AHB system bus. When dwc3 is
> connected with USB 2.5G Ethernet, there will be overrun problem.
> Therefore, setting TX/RX thresholds can avoid this issue.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>      Move the threshold setting to new function dwc3_config_threshold.
>      Add the threshold setting for usb31 and usb32
> v1 to v2 change:
>      Add the properties for TX/RX threshold setting
> ---
>   drivers/usb/dwc3/core.c | 160 +++++++++++++++++++++++++++++++---------
>   drivers/usb/dwc3/core.h |  13 ++++
>   2 files changed, 137 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9c6bf054f15d..44ee8526dc28 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1057,6 +1057,111 @@ static void dwc3_set_power_down_clk_scale(struct dwc3 *dwc)
>   	}
>   }
>   
> +static void dwc3_config_threshold(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +	u8 rx_thr_num;
> +	u8 rx_maxburst;
> +	u8 tx_thr_num;
> +	u8 tx_maxburst;
> +
> +	/*
> +	 * Must config both number of packets and max burst settings to enable
> +	 * RX and/or TX threshold.
> +	 */
> +	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
> +		rx_thr_num = dwc->rx_thr_num_pkt_prd;
> +		rx_maxburst = dwc->rx_max_burst_prd;
> +		tx_thr_num = dwc->tx_thr_num_pkt_prd;
> +		tx_maxburst = dwc->tx_max_burst_prd;
> +
> +		if (rx_thr_num && rx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
> +			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
> +
> +			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
> +			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
> +
> +			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
> +			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
> +		}
> +
> +		if (tx_thr_num && tx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
> +			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
> +
> +			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
> +			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
> +
> +			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
> +			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
> +		}
> +	}
> +
> +	rx_thr_num = dwc->rx_thr_num_pkt;
> +	rx_maxburst = dwc->rx_max_burst;
> +	tx_thr_num = dwc->tx_thr_num_pkt;
> +	tx_maxburst = dwc->tx_max_burst;
> +
> +	if (DWC3_IP_IS(DWC3)) {
> +		if (rx_thr_num && rx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
> +			reg |= DWC3_GRXTHRCFG_PKTCNTSEL;
> +
> +			reg &= ~DWC3_GRXTHRCFG_RXPKTCNT(~0);
> +			reg |= DWC3_GRXTHRCFG_RXPKTCNT(rx_thr_num);
> +
> +			reg &= ~DWC3_GRXTHRCFG_MAXRXBURSTSIZE(~0);
> +			reg |= DWC3_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
> +		}
> +
> +		if (tx_thr_num && tx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
> +			reg |= DWC3_GTXTHRCFG_PKTCNTSEL;
> +
> +			reg &= ~DWC3_GTXTHRCFG_TXPKTCNT(~0);
> +			reg |= DWC3_GTXTHRCFG_TXPKTCNT(tx_thr_num);
> +
> +			reg &= ~DWC3_GTXTHRCFG_MAXTXBURSTSIZE(~0);
> +			reg |= DWC3_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
> +		}
> +	} else {
> +		if (rx_thr_num && rx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
> +			reg |= DWC31_GRXTHRCFG_PKTCNTSEL;
> +
> +			reg &= ~DWC31_GRXTHRCFG_RXPKTCNT(~0);
> +			reg |= DWC31_GRXTHRCFG_RXPKTCNT(rx_thr_num);
> +
> +			reg &= ~DWC31_GRXTHRCFG_MAXRXBURSTSIZE(~0);
> +			reg |= DWC31_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
> +		}
> +
> +		if (tx_thr_num && tx_maxburst) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
> +			reg |= DWC31_GTXTHRCFG_PKTCNTSEL;
> +
> +			reg &= ~DWC31_GTXTHRCFG_TXPKTCNT(~0);
> +			reg |= DWC31_GTXTHRCFG_TXPKTCNT(tx_thr_num);
> +
> +			reg &= ~DWC31_GTXTHRCFG_MAXTXBURSTSIZE(~0);
> +			reg |= DWC31_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
> +
> +			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
> +		}
> +	}
> +}
> +
>   /**
>    * dwc3_core_init - Low-level initialization of DWC3 Core
>    * @dwc: Pointer to our controller context structure
> @@ -1209,42 +1314,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
>   	}
>   
> -	/*
> -	 * Must config both number of packets and max burst settings to enable
> -	 * RX and/or TX threshold.
> -	 */
> -	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
> -		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
> -		u8 rx_maxburst = dwc->rx_max_burst_prd;
> -		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
> -		u8 tx_maxburst = dwc->tx_max_burst_prd;
> -
> -		if (rx_thr_num && rx_maxburst) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
> -			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
> -
> -			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
> -			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
> -
> -			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
> -			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
> -
> -			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
> -		}
> -
> -		if (tx_thr_num && tx_maxburst) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
> -			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
> -
> -			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
> -			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
> -
> -			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
> -			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
> -
> -			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
> -		}
> -	}
> +	dwc3_config_threshold(dwc);
>   
>   	return 0;
>   
> @@ -1380,6 +1450,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>   	u8			lpm_nyet_threshold;
>   	u8			tx_de_emphasis;
>   	u8			hird_threshold;
> +	u8			rx_thr_num_pkt = 0;
> +	u8			rx_max_burst = 0;
> +	u8			tx_thr_num_pkt = 0;
> +	u8			tx_max_burst = 0;
>   	u8			rx_thr_num_pkt_prd = 0;
>   	u8			rx_max_burst_prd = 0;
>   	u8			tx_thr_num_pkt_prd = 0;
> @@ -1442,6 +1516,14 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>   				"snps,usb2-lpm-disable");
>   	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
>   				"snps,usb2-gadget-lpm-disable");
> +	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
> +				&rx_thr_num_pkt);
> +	device_property_read_u8(dev, "snps,rx-max-burst",
> +				&rx_max_burst);
> +	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
> +				&tx_thr_num_pkt);
> +	device_property_read_u8(dev, "snps,tx-max-burst",
> +				&tx_max_burst);

Aren't there value limitations for some of these (if not all) settings? 
  For example, in the DWC3 programming guide, the max burst fields say 
(for DWC31):
	"Note: This field can only be set to 2, 4, 8 or 16."

And for the packet threshold count:
	"Valid values are from 1 to 16."

Thanks
Wesley Cheng

>   	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
>   				&rx_thr_num_pkt_prd);
>   	device_property_read_u8(dev, "snps,rx-max-burst-prd",
> @@ -1523,6 +1605,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>   
>   	dwc->hird_threshold = hird_threshold;
>   
> +	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
> +	dwc->rx_max_burst = rx_max_burst;
> +
> +	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
> +	dwc->tx_max_burst = tx_max_burst;
> +
>   	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
>   	dwc->rx_max_burst_prd = rx_max_burst_prd;
>   
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index a69ac67d89fe..6782ec8bfd64 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -211,6 +211,11 @@
>   #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
>   #define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
>   
> +/* Global TX Threshold Configuration Register */
> +#define DWC3_GTXTHRCFG_MAXTXBURSTSIZE(n) (((n) & 0xff) << 16)
> +#define DWC3_GTXTHRCFG_TXPKTCNT(n) (((n) & 0xf) << 24)
> +#define DWC3_GTXTHRCFG_PKTCNTSEL BIT(29)
> +
>   /* Global RX Threshold Configuration Register for DWC_usb31 only */
>   #define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
>   #define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
> @@ -1045,6 +1050,10 @@ struct dwc3_scratchpad_array {
>    * @test_mode_nr: test feature selector
>    * @lpm_nyet_threshold: LPM NYET response threshold
>    * @hird_threshold: HIRD threshold
> + * @rx_thr_num_pkt: USB receive packet count
> + * @rx_max_burst: max USB receive burst size
> + * @tx_thr_num_pkt: USB transmit packet count
> + * @tx_max_burst: max USB transmit burst size
>    * @rx_thr_num_pkt_prd: periodic ESS receive packet count
>    * @rx_max_burst_prd: max periodic ESS receive burst size
>    * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
> @@ -1273,6 +1282,10 @@ struct dwc3 {
>   	u8			test_mode_nr;
>   	u8			lpm_nyet_threshold;
>   	u8			hird_threshold;
> +	u8			rx_thr_num_pkt;
> +	u8			rx_max_burst;
> +	u8			tx_thr_num_pkt;
> +	u8			tx_max_burst;
>   	u8			rx_thr_num_pkt_prd;
>   	u8			rx_max_burst_prd;
>   	u8			tx_thr_num_pkt_prd;
