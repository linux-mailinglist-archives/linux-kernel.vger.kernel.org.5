Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791917C9A17
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjJOQi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:38:58 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E947AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1697387932; bh=pYockNRZjc2dNPr8vNuS5tNYZ7arbBBQ8q6BRdmWjPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIeIBbn9rTNW7IEL7TMs5zHhkSPHaODkBbeWfKvqBsDgIlBEK4cRZqCHVxL9gwJ7B
         PLdgjQW7Q+WWrzX1HOrK1SPF+EJrC5BvyEazKfCzFtZ1lzS0hupaVEOVsVYVo8ylZ+
         lr81mcFwhN/kvgKysKyCMr+NigcWylk/w3yoix7U=
Date:   Sun, 15 Oct 2023 18:38:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: remove unused function prototypes
Message-ID: <d6204b3b-9a6c-425b-8915-9feb36526f5f@t-8ch.de>
References: <ZSv2ObWLvlbM2hXn@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSv2ObWLvlbM2hXn@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calvince,

On 2023-10-15 17:24:57+0300, Calvince Otieno wrote:
> These functions are declared but not defined or used anywhere.
> Their definitions were removed 15 years ago in the
> commit cbec30c4c00c ("Staging: wlan-ng: Delete a large pile of
> now-unused code.")

The indicated commit seems to be incorrect for prism2mgmt_set_grpaddr().

Also for new versions of patches it is useful to explicitly Cc people
that commented on the previous versions. These people people may be
curious about the progress and it makes it easier for the patch to
receive a Reviewed-by from them.

Plus the points from the document linked by Greg's bot.

* Changelog compared to previous version.
* Increment of patch version counter in subject
(* Link to previous version of patch in lore.kernel.org)

> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2mgmt.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
> index 083a055ee986..8c3f1ac35913 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.h
> +++ b/drivers/staging/wlan-ng/prism2mgmt.h
> @@ -78,14 +78,6 @@ void prism2mgmt_pstr2bytestr(struct hfa384x_bytestr *bytestr,
>  void prism2mgmt_bytestr2pstr(struct hfa384x_bytestr *bytestr,
>  			     struct p80211pstrd *pstr);
>  
> -/* functions to convert Group Addresses */
> -void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
> -			    struct hfa384x *priv);
> -int prism2mgmt_set_grpaddr(u32 did,
> -			   u8 *prism2buf, struct p80211pstrd *pstr,
> -			   struct hfa384x *priv);
> -int prism2mgmt_get_grpaddr_index(u32 did);
> -
>  void prism2sta_processing_defer(struct work_struct *data);
>  
>  void prism2sta_commsqual_defer(struct work_struct *data);
> -- 
> 2.34.1
> 
