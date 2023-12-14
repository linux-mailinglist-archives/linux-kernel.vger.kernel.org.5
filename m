Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047E48124FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjLNCIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:08:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E4E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:08:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28ae571b2edso928919a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702519696; x=1703124496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qShNyLDmN+8IdcHnMPIUGtk6Jx1xybC2q6g+/Fg38uw=;
        b=fUsUytfZVHYe5jB/M99+nPVBP/ghSkIVtppT+4H8eKMpNIlK2s8QriEJyhrJXpDPdI
         Nv/nCYBzmvmChtZgCR5UqqxhRkC14yRk1tpX0FYuGSnfm+Q6HlYQOXkGtTU75wgzwjaD
         Yi+fUqx8OI/nm5rGNylSgR+iRO0i3bsAXdWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519696; x=1703124496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qShNyLDmN+8IdcHnMPIUGtk6Jx1xybC2q6g+/Fg38uw=;
        b=YyMNsby68GCWpJQqNkANymVMqnKzk1rDmOu+WfLbxE86fUVzovwKqmCy5nJOWaytcc
         jGeOBYJCHS2V+yTkyEnHmfmCoMosFDdbfDIVqvumXjPif6vOncNT1FpeGV/y9fpbMiKz
         mYckZimB8GRGXCfeSKQfDwLjfaU5ggo2byIk8Gb4OvMDAxyktLH0CQhZGI/nwaMyAgry
         r4Rn0CieJpkAFYsvfskfVWUfq7p3VQZVyVxIOgZUCPoZdV6cv8PbHWMNq6iT/8iMWInp
         UsgyRryZq1f2nAq+VNReK7Q8vpx3/gxMiZ2wBeGqpfMGKw4YVrSkDmXqb79BBAE10Arf
         iIyQ==
X-Gm-Message-State: AOJu0Yz8mTJyYQdiQXJd//Ybj5Zdt05ojPCLjCjGS7MrhxJI4E5M1yg4
        OyvwzQdzh7rrF0bsLC6gTviubA==
X-Google-Smtp-Source: AGHT+IEPabyCmug2FZX5OX8mOdwgFWcT5xhOBOTmVRK23klj0sBiFix6IBT+AyWyXDLvszIEihTHLg==
X-Received: by 2002:a05:6a20:ce83:b0:18f:c24e:7249 with SMTP id if3-20020a056a20ce8300b0018fc24e7249mr4358658pzb.90.1702519696466;
        Wed, 13 Dec 2023 18:08:16 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:17f:673b:ab18:3603])
        by smtp.gmail.com with UTF8SMTPSA id s13-20020a170902ea0d00b001d1d27259cesm11188492plg.180.2023.12.13.18.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 18:08:16 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:08:14 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Message-ID: <ZXpjjmD5Se7axJju@google.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234127.2251-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nitpick: "fix STA cannot connect to AP" isn't the best commit message;
that could describe an enormous number of fixes. Maybe something more
like "Configure BSSID consistently when starting AP"?

On Sat, Dec 09, 2023 at 07:41:27AM +0800, David Lin wrote:
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
>    - v1 was a not finished patch that was send to the LKML by mistake

Looks fine to me:

Acked-by: Brian Norris <briannorris@chromium.org>

>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
>  drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
>  drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
>  4 files changed, 12 insertions(+)

> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c

> @@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
>  	int i;
>  	u16 cmd_size = *param_size;
>  
> +	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;

Not directly related to this patch, but while you're expanding the size
of this command buffer: it always felt like a security-hole-in-waiting
that none of these command producers do any kinds of bounds checking.
We're just "lucky" that these function only generate contents of ~100
bytes at max, while MWIFIEX_SIZE_OF_CMD_BUFFER=2048. But, just add a few
more user-space controlled TLV params, and boom, we'll have ourselves a
nice little CVE.

It probably wouldn't hurt to significantly write much of this driver,
but at a minimum, we could probably use a few checks like this:

	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
	if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
		return -1;
	// Only touch tlv *after* the bounds check.

That doesn't need to block this patch, of course.

Brian

> +	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
> +	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
> +	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
> +	cmd_size += sizeof(struct host_cmd_tlyyv_mac_addr);
> +	tlv += sizeof(struct host_cmd_tlv_mac_addr);
> +
>  	if (bss_cfg->ssid.ssid_len) {
>  		ssid = (struct host_cmd_tlv_ssid *)tlv;
>  		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
> 
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
> -- 
> 2.25.1
> 
