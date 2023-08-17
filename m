Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4159677FAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353171AbjHQPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbjHQPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8DB1AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735A661E4E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB0C433C7;
        Thu, 17 Aug 2023 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285665;
        bh=3rq0+j4/8fuL5mrl3zVQ3TjWRax2AO1eFRL2f46GGng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bBrjCRqMRSg4kiKciMHscs6niYTM6AKz28x7rYyNv3ftzZjT/4nT03c8vrX2bnyI5
         Rj2zSnzFW/CeYw2mxjo58zZuJJEWuWY57/Vm4u7z+O0IZoiZenKHisE3ycgHdtVn4n
         54CzPyHULebWwPsZtCd0ewgGwqYGGQxsF/F/RyF7H5gNstJLjd70O1gacoMRGr94nD
         yBUrhnTaCNEVwSF2C7/AT1zn5EiragT4n5ZyB2D10AItLyq6Jc632HlYFVknZ18y71
         deHWNfd4HJ2AdB45lz1T/XEtKFeH3YWNYVs3xLHhLdBi5gh0ZxejogNrtKu01iPUe/
         nwwHn5tXnm+oA==
Message-ID: <90ccff97-5c2e-3dd0-8f96-05c6f3402334@kernel.org>
Date:   Thu, 17 Aug 2023 23:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] f2fs: doc: fix description of max_small_discards
Content-Language: en-US
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230730142552.3918623-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230730142552.3918623-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2023/7/30 22:25, Chao Yu wrote:
> The description of max_small_discards is out-of-update in below two
> aspects, fix it.
> - it is disabled by default
> - small discards will be issued during checkpoint
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index ad3d76d37c8b..36c3cb547901 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -102,9 +102,9 @@ What:		/sys/fs/f2fs/<disk>/max_small_discards
>   Date:		November 2013
>   Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>   Description:	Controls the issue rate of discard commands that consist of small
> -		blocks less than 2MB. The candidates to be discarded are cached until
> -		checkpoint is triggered, and issued during the checkpoint.
> -		By default, it is disabled with 0.
> +		blocks less than 2MB. The candidates to be discarded are cached during
> +		checkpoint, and issued by issue_discard thread after checkpoint.
> +		It is enabled by default.
>   
>   What:		/sys/fs/f2fs/<disk>/max_ordered_discard
>   Date:		October 2022
