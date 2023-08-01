Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D928A76BBD2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjHAR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjHAR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:57:58 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A581127;
        Tue,  1 Aug 2023 10:57:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFjG9264zz9xGhY;
        Wed,  2 Aug 2023 01:46:25 +0800 (CST)
Received: from [10.81.206.119] (unknown [10.81.206.119])
        by APP2 (Coremail) with SMTP id GxC2BwBnZu5+R8lkgoweAA--.27039S2;
        Tue, 01 Aug 2023 18:57:32 +0100 (CET)
Message-ID: <327159d6-f520-bea1-c6b0-facda7c26699@huaweicloud.com>
Date:   Tue, 1 Aug 2023 19:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] wifi: brcm80211: drop struct brcmf_p2p_scan_le
Content-Language: en-US
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <SHA-cyfmac-dev-list@infineon.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
 <b94c048c8decefeca41ceac5f826da67a8d727a8.1690904067.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <b94c048c8decefeca41ceac5f826da67a8d727a8.1690904067.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBnZu5+R8lkgoweAA--.27039S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13Xr1xZFWrCrWftF4DCFg_yoWrJF4kpF
        yfXa4qgrnxXw429r4UXa1kArWIv3y2qw1ktFyYvw13KFn8Crn3JFWDKr109rWUC3yfA3yY
        vF45tF4UZrW2ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUFf
        HUDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 5:36 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The 'S' scan method is not implemented. The type member is always written
> as 'E' and never read. Consequently, struct brcmf_p2p_scan_le can be
> replaced with struct brcmf_escan_params_le.

Seeing that Hans has already fixed the actual issue with the flex array,
this whole series is not needed.

But maybe this simplification has some value on its own?

Petr T

> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/p2p.c         | 38 ++++---------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index d4492d02e4ea..915f95760470 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -123,23 +123,6 @@ enum brcmf_p2p_disc_state {
>  	WL_P2P_DISC_ST_SEARCH
>  };
>  
> -/**
> - * struct brcmf_p2p_scan_le - P2P specific scan request.
> - *
> - * @type: type of scan method requested (values: 'E' or 'S').
> - * @reserved: reserved (ignored).
> - * @eparams: parameters used for type 'E'.
> - * @sparams: parameters used for type 'S'.
> - */
> -struct brcmf_p2p_scan_le {
> -	u8 type;
> -	u8 reserved[3];
> -	union {
> -		struct brcmf_escan_params_le eparams;
> -		struct brcmf_scan_params_le sparams;
> -	};
> -};
> -
>  /**
>   * struct brcmf_p2p_pub_act_frame - WiFi P2P Public Action Frame
>   *
> @@ -646,14 +629,14 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
>  {
>  	struct brcmf_pub *drvr = p2p->cfg->pub;
>  	s32 ret = 0;
> -	s32 memsize = offsetof(struct brcmf_p2p_scan_le,
> -			       eparams.params_le.channel_list);
> +	s32 memsize = offsetof(struct brcmf_escan_params_le,
> +			       params_le.channel_list);
>  	s32 nprobes;
>  	s32 active;
>  	u32 i;
>  	u8 *memblk;
>  	struct brcmf_cfg80211_vif *vif;
> -	struct brcmf_p2p_scan_le *p2p_params;
> +	struct brcmf_escan_params_le *eparams;
>  	struct brcmf_scan_params_le *sparams;
>  
>  	memsize += num_chans * sizeof(__le16);
> @@ -667,8 +650,8 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
>  		ret = -EINVAL;
>  		goto exit;
>  	}
> -	p2p_params = (struct brcmf_p2p_scan_le *)memblk;
> -	sparams = &p2p_params->eparams.params_le;
> +	eparams = (struct brcmf_escan_params_le *)memblk;
> +	sparams = &eparams->params_le;
>  
>  	switch (search_state) {
>  	case WL_P2P_DISC_ST_SEARCH:
> @@ -698,11 +681,6 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
>  
>  	brcmf_p2p_set_discover_state(vif->ifp, search_state, 0, 0);
>  
> -	/*
> -	 * set p2p scan parameters.
> -	 */
> -	p2p_params->type = 'E';
> -
>  	/* determine the scan engine parameters */
>  	sparams->bss_type = DOT11_BSSTYPE_ANY;
>  	sparams->scan_type = BRCMF_SCANTYPE_ACTIVE;
> @@ -747,9 +725,9 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
>  		sparams->channel_list[i] = cpu_to_le16(chanspecs[i]);
>  
>  	/* set the escan specific parameters */
> -	p2p_params->eparams.version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
> -	p2p_params->eparams.action =  cpu_to_le16(WL_ESCAN_ACTION_START);
> -	p2p_params->eparams.sync_id = cpu_to_le16(0x1234);
> +	eparams->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
> +	eparams->action =  cpu_to_le16(WL_ESCAN_ACTION_START);
> +	eparams->sync_id = cpu_to_le16(0x1234);
>  	/* perform p2p scan on primary device */
>  	ret = brcmf_fil_bsscfg_data_set(vif->ifp, "p2p_scan", memblk, memsize);
>  	if (!ret)

