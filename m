Return-Path: <linux-kernel+bounces-125779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02DF892C03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF90B225EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E43C068;
	Sat, 30 Mar 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBnkvFVO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB62030B;
	Sat, 30 Mar 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815685; cv=none; b=F2Vw7b2iLqM3n128NeQvEckbwjEihlp64yLdaMD/N4tvyMwpbltZ6I/6s3vUVOjmQatvylwvse8pabq/Jl6KrAbyInkhL8R4Lp6P+4NlpHxjOxWFB8Ru16hy+3rhSq8zA9/SkhOeV6dF01wyX1LsjS5OvZt9YD2VXej22+zYY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815685; c=relaxed/simple;
	bh=S8+0R8Wzgncrsj4aVwsIfmzFytuLRDi84n0w/4rbXDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxJEjTCOsRjU2upf1FHBoDgF6BVCirf82PjrSjQ0+4Xx7Ec4s3PHwPGQMCGeKG+AaGbcJdUOmtKWAIujF43NvleZty/ZklWnmZ7DWJGxglwP32J5qkPSC20j63tdPcKkZLhbMaMxnUpEt+HD8RL9El97awvC4IPq9qKXasfTGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MBnkvFVO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9j1DIWRaxBbCDyZd26BiEylt/k3NJ0jHmIbzDeNJBTU=; b=MBnkvFVOH7dfsJCVrxrPFnGQ9B
	bUItCE2FaVDGCYcEpSjbPZMC6Oymnk2Gyc59lZYxfuL7mr74fM9dfJxccef+GUqDnBTmPWvwb+vp9
	a0k8qXDttGov5PiEdin7uj+AfntBudBcYWPlr3Igrvh3TfSXdodWlinskmFJgTnEuX2UHkiAxrJHs
	a1oleU7OkQelWh5yz16YkRXP7vJRDCRkAISq6dKwwFh0MufmpmRi1VeOnPmQndMvfKqgxwdiEELLh
	0Zt8Lbepa4k83EWPFVU3aYdg2QmdSQxx9/jkcbf3nTWhNchzEhbgyUZTue7hYlxo//CrheE/Ej3Vy
	CnI9XU/A==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqbSG-00000003mZz-27oi;
	Sat, 30 Mar 2024 16:21:16 +0000
Message-ID: <f951fc3e-ee8f-468d-9607-d8cd1afe6b9d@infradead.org>
Date: Sat, 30 Mar 2024 09:21:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mac80211: Add missing return value
 documentation
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
 <20240329-mac80211-kdoc-retval-v1-2-5e4d1ad6c250@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-2-5e4d1ad6c250@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/29/24 13:27, Jeff Johnson wrote:
> kernel-doc is reporting some warnings, so fix them:
> 
> % scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
> include/net/mac80211.h:2056: warning: No description found for return value of 'wdev_to_ieee80211_vif'
> include/net/mac80211.h:2066: warning: No description found for return value of 'ieee80211_vif_to_wdev'
> include/net/mac80211.h:5603: warning: No description found for return value of 'ieee80211_beacon_cntdwn_is_complete'
> include/net/mac80211.h:5968: warning: No description found for return value of 'ieee80211_gtk_rekey_add'
> include/net/mac80211.h:6350: warning: No description found for return value of 'ieee80211_find_sta_by_link_addrs'
> include/net/mac80211.h:6478: warning: No description found for return value of 'ieee80211_txq_airtime_check'
> include/net/mac80211.h:6981: warning: No description found for return value of 'rate_control_set_rates'
> include/net/mac80211.h:7142: warning: No description found for return value of 'ieee80211_tx_prepare_skb'
> include/net/mac80211.h:7156: warning: No description found for return value of 'ieee80211_parse_tx_radiotap'
> include/net/mac80211.h:7277: warning: No description found for return value of 'ieee80211_tx_dequeue'
> include/net/mac80211.h:7292: warning: No description found for return value of 'ieee80211_tx_dequeue_ni'
> include/net/mac80211.h:7324: warning: No description found for return value of 'ieee80211_next_txq'
> include/net/mac80211.h:7405: warning: No description found for return value of 'ieee80211_txq_may_transmit'
> include/net/mac80211.h:7466: warning: No description found for return value of 'ieee80211_calc_rx_airtime'
> include/net/mac80211.h:7480: warning: No description found for return value of 'ieee80211_calc_tx_airtime'
> include/net/mac80211.h:7528: warning: No description found for return value of 'ieee80211_is_tx_data'
> include/net/mac80211.h:7562: warning: No description found for return value of 'ieee80211_set_active_links'
> 17 warnings as Errors
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> ---
>  include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index e6a11a982ca8..8984ac4359b8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
>   * This can be used by mac80211 drivers with direct cfg80211 APIs
>   * (like the vendor commands) that get a wdev.
>   *
> - * Note that this function may return %NULL if the given wdev isn't
> + * Return: pointer to the wdev, or %NULL if the given wdev isn't
>   * associated with a vif that the driver knows about (e.g. monitor
>   * or AP_VLAN interfaces.)
>   */
> @@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
>   * This can be used by mac80211 drivers with direct cfg80211 APIs
>   * (like the vendor commands) that needs to get the wdev for a vif.
>   * This can also be useful to get the netdev associated to a vif.
> + *
> + * Return: pointer to the wdev
>   */
>  struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
>  
> @@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
>   * @vif: &struct ieee80211_vif pointer from the add_interface callback.
>   * @link_id: valid link_id during MLO or 0 for non-MLO
>   *
> - * This function returns whether the countdown reached zero.
> + * Return: %true if the countdown reached 1, %false otherwise
>   */
>  bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
>  					 unsigned int link_id);
> @@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
>   * key(s) will be available. These will be needed by mac80211 for proper
>   * RX processing, so this function allows setting them.
>   *
> - * The function returns the newly allocated key structure, which will
> - * have similar contents to the passed key configuration but point to
> + * Return: the newly allocated key structure, which will have
> + * similar contents to the passed key configuration but point to
>   * mac80211-owned memory. In case of errors, the function returns an
>   * ERR_PTR(), use IS_ERR() etc.
>   *
> @@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(struct ieee80211_hw *hw,
>   *	may be %NULL if the link ID is not needed
>   *
>   * Obtain the STA by link address, must use RCU protection.
> + *
> + * Return: pointer to STA if found, otherwise %NULL.
>   */
>  struct ieee80211_sta *
>  ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
> @@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
>   * @hw: pointer obtained from ieee80211_alloc_hw()
>   * @txq: pointer obtained from station or virtual interface
>   *
> - * Return true if the AQL's airtime limit has not been reached and the txq can
> - * continue to send more packets to the device. Otherwise return false.
> + * Return: %true if the AQL's airtime limit has not been reached and the txq can
> + * continue to send more packets to the device. Otherwise return %false.
>   */
>  bool
>  ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
> @@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_supported_band *sband,
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @pubsta: &struct ieee80211_sta pointer to the target destination.
>   * @rates: new tx rate set to be used for this station.
> + *
> + * Return: 0 on success. An error code otherwise.
>   */
>  int rate_control_set_rates(struct ieee80211_hw *hw,
>  			   struct ieee80211_sta *pubsta,
> @@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
>   * @band: the band to transmit on
>   * @sta: optional pointer to get the station to send the frame to
>   *
> + * Return: %true if the skb was prepared, %false otherwise
> + *
>   * Note: must be called under RCU lock
>   */
>  bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
> @@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
>   *
>   * @skb: packet injected by userspace
>   * @dev: the &struct device of this 802.11 device
> + *
> + * Return: %true if the radiotap header was parsed, %false otherwise
>   */
>  bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
>  				 struct net_device *dev);
> @@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *sta, u8 tid);
>   * @txq: pointer obtained from station or virtual interface, or from
>   *	ieee80211_next_txq()
>   *
> - * Returns the skb if successful, %NULL if no frame was available.
> + * Return: the skb if successful, %NULL if no frame was available.
>   *
>   * Note that this must be called in an rcu_read_lock() critical section,
>   * which can only be released after the SKB was handled. Some pointers in
> @@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @txq: pointer obtained from station or virtual interface, or from
>   *	ieee80211_next_txq()
> + *
> + * Return: the skb if successful, %NULL if no frame was available.
>   */
>  static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw *hw,
>  						      struct ieee80211_txq *txq)
> @@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @ac: AC number to return packets from.
>   *
> - * Returns the next txq if successful, %NULL if no queue is eligible. If a txq
> + * Return: the next txq if successful, %NULL if no queue is eligible. If a txq
>   * is returned, it should be returned with ieee80211_return_txq() after the
>   * driver has finished scheduling it.
>   */
> @@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
>   *
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @txq: pointer obtained from station or virtual interface
> + *
> + * Return: %true if transmission is allowed, %false otherwise
>   */
>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>  				struct ieee80211_txq *txq);
> @@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
>   * @status: &struct ieee80211_rx_status containing the transmission rate
>   *          information.
>   * @len: frame length in bytes
> + *
> + * Return: the airtime estimate
>   */
>  u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>  			      struct ieee80211_rx_status *status,
> @@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @info: &struct ieee80211_tx_info of the frame.
>   * @len: frame length in bytes
> + *
> + * Return: the airtime estimate
>   */
>  u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>  			      struct ieee80211_tx_info *info,
> @@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
>   * hardware encapsulation enabled are data frames.
>   *
>   * @skb: the frame to be transmitted.
> + *
> + * Return: %true if @skb is a data frame, %false otherwise
>   */
>  static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
>  {
> @@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
>   *  - change_sta_links(0x10) for each affected STA (the AP)
>   *  - assign_vif_chanctx(link_id=4)
>   *  - change_vif_links(0x10)
> + *
> + * Return: 0 on success. An error code otherwise.
>   */
>  int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
>  
> 

-- 
#Randy

