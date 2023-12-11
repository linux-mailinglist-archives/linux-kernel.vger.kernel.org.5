Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A7480D3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbjLKR3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjLKR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:29:35 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA2BD;
        Mon, 11 Dec 2023 09:29:41 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF1DF5C0479;
        Mon, 11 Dec 2023 12:29:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 12:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1702315780; x=1702402180; bh=2y/zHAmItwL8OLyqtKwhwW8HQM0dfoFeDOX
        CuDtL5jY=; b=OTy/ybrowVGxYNSZ70/OkClauC+SwRDhCo8BO4hk+NyNTIrx/XN
        a4cJrAGjP77eoBbANUDFWJeuNJJh1RBstFJPeZnhn/jistJnLzYRR2phXvciHCdP
        NDSj+w/xzAiPgD8z8bnuxNJTdNFt4BfEzVx3j8grxyREit31bs+oK2WjcBThviMo
        bPa5ZrJLnTmtHrCUC0nk3lD1a5DgwSIL5YniAtKwdPNcr8TBGbrofcPFZWidQqQ9
        0o9geG3C7DQbO3iiNHvtYEcPhxSuGBvXU6uiVhC7k6/MTuJFYbchkTuRtAsOYvTZ
        zXMBqio4Y4bK1aF4yy+7PVTa87iCmni8tCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1702315780; x=1702402180; bh=2y/zHAmItwL8OLyqtKwhwW8HQM0dfoFeDOX
        CuDtL5jY=; b=aW7GQS63pqc7e/4BtbcB22dDq97GhrFPOrjWKm8kkeQQ8Dsjb9Z
        dDv54llNtBaH8+Y6hepyWtJplOmYWI6NpdTUf1HtOx3lDfwJBvKLH3zVakMiX2R5
        wzoVLZ4bhLrRh9pyvwubUE0MAqp6/BYVaw7abRIHaSvsDA5fqqmia17OUomjO97m
        sPxU7ERZgTopnJq2MWDQDmYrntW5FXFh0KmhssyjsPE0lNIHQYmTjbMh1CUwGMqx
        Mwe8Uq/R7F79lQj86O1m13PVNrUiq+KoA+XFxMCIFxT3XgqI682BghGbFZvRNTwg
        Yr3s4G5SZWjISNw8tFapABzPOEvT6GvcHdw==
X-ME-Sender: <xms:BEd3ZUMQTPZ2da4hDrVlkxvxQFPyw2Dge-P5hZsGneUGa0GBRLZsFA>
    <xme:BEd3Za86uZSJQVJJZ0EC_54-JfUwzP116nVeL5lMMEkVRd72Axon2xeQTTC1K2QFf
    Zusi-OfrANu5jjFDXo>
X-ME-Received: <xmr:BEd3ZbSOS5D8wmxQALbCwHvjZtL_sAnWiDD7tsNhgj1ng0nxqJCY0lPqNfWP3G5v5vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgse
    htjeertddtvdejnecuhfhrohhmpeftrghfrggvlhcuuegvihhmshcuoehrrghfrggvlhes
    sggvihhmshdrmhgvqeenucggtffrrghtthgvrhhnpeejieejvdelgeduveejgeeltdevie
    efteejleeiieejgeeihfelleehtdegudeiieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:BEd3ZcvmND0bEMb1C4YAq47zEc1SibJ4GyCYhO_DrfzT4HoyJvdWlw>
    <xmx:BEd3ZcdqSKALFBAAyvvLvZahTdFS8pxK1LGofwQBuudXC3pl4iBCrw>
    <xmx:BEd3ZQ3dHtG3FK8-SYkxS08MK435LNxImOBqekxXPVq12y00Apqm7Q>
    <xmx:BEd3ZUQMOkvygvf1pKi6qk7E8IxYOqD4ZIRamIgjxHUJrgMq7_rtCQ>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 12:29:38 -0500 (EST)
Message-ID: <1c7f8394-f81d-42d5-948b-b1855ad013d5@beims.me>
Date:   Mon, 11 Dec 2023 14:29:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Content-Language: pt-BR
To:     David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        stable@vger.kernel.org
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
From:   Rafael Beims <rafael@beims.me>
In-Reply-To: <20231208234127.2251-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 20:41, David Lin wrote:
> AP BSSID configuration is missing at AP start.
> Without this fix, FW returns STA interface MAC address after first init.
> When hostapd restarts, it gets MAC address from netdev before driver
> sets STA MAC to netdev again. Now MAC address between hostapd and net
> interface are different causes STA cannot connect to AP.
> After that MAC address of uap0 mlan0 become the same. And issue
> disappears after following hostapd restart (another issue is AP/STA MAC
> address become the same).
> This patch fixes the issue cleanly.
>
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
> Cc: stable@vger.kernel.org
>
> ---
>
> v2:
>     - v1 was a not finished patch that was send to the LKML by mistake
> ---
>   drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
>   drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
>   drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
>   drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
>   4 files changed, 12 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 7a15ea8072e6..3604abcbcff9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -2047,6 +2047,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
>   
>   	mwifiex_set_sys_config_invalid_data(bss_cfg);
>   
> +	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
> +
>   	if (params->beacon_interval)
>   		bss_cfg->beacon_period = params->beacon_interval;
>   	if (params->dtim_period)
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 8e6db904e5b2..62f3c9a52a1d 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -165,6 +165,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
>   #define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID + 32)
>   #define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
>   #define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID + 42)
> +#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID + 43)
>   #define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID + 44)
>   #define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID + 45)
>   #define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
> diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
> index 091e7ca79376..e8825f302de8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
> +++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
> @@ -107,6 +107,7 @@ struct mwifiex_uap_bss_param {
>   	u8 qos_info;
>   	u8 power_constraint;
>   	struct mwifiex_types_wmm_info wmm_info;
> +	u8 mac_addr[ETH_ALEN];
>   };
>   
>   enum {
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index e78a201cd150..491e36611909 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -468,6 +468,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
>   static int
>   mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
>   {
> +	struct host_cmd_tlv_mac_addr *mac_tlv;
>   	struct host_cmd_tlv_dtim_period *dtim_period;
>   	struct host_cmd_tlv_beacon_period *beacon_period;
>   	struct host_cmd_tlv_ssid *ssid;
> @@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
>   	int i;
>   	u16 cmd_size = *param_size;
>   
> +	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
> +	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
> +	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
> +	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
> +	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
> +	tlv += sizeof(struct host_cmd_tlv_mac_addr);
> +
>   	if (bss_cfg->ssid.ssid_len) {
>   		ssid = (struct host_cmd_tlv_ssid *)tlv;
>   		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
>
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c


Tested-by: Rafael Beims <rafael.beims@toradex.com> # Verdin iMX8MP / 
SD8997 SD


Rafael

