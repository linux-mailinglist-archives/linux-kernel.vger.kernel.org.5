Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DF79A360
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjIKGOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIKGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FECEC;
        Sun, 10 Sep 2023 23:14:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F254C433C8;
        Mon, 11 Sep 2023 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694412841;
        bh=ORe7C332iYyo5IYXrlgyWRlPgfxg6kZ0nvvhF0VUJk4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qHVFnIMQwhFozh539l++jyDP4PtPacH1m7mPDqKh3G3JcIMPUShXdk04OIc5bkWjb
         NHV1L1ujQov87qon1E/cp+8ireazSHrr8ZK09nTLQdgfo/im1FiM2yqtyeRbOTKCRW
         2gdkwiJ5Ux9Tfy9cQOWXWlAGLSxs15UmL5JPS/UI3pDU3To4zFjOVtWQALM8QnfUrS
         YjgpUn3o6ThNq+f02xVwQrcLrsJcAxoEtcAgmE9lfbWyVO288EpDab4M7BAXPcmuG5
         UUNuyyGjoW07b/YYkUU0niByhXrxbbcJXsMBEBBdc+BslLmTrCsrq1TeHE5tZ+3EdZ
         EIEsjCMbEzvXQ==
Message-ID: <9ec1c919-504a-a50a-4f75-5a1ab63b1ab5@kernel.org>
Date:   Mon, 11 Sep 2023 15:14:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: sata_mv: Fix incorrect string length computation in
 mv_dump_mem()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 04:54, Christophe JAILLET wrote:
> snprintf() returns the "number of characters which *would* be generated for
> the given input", not the size *really* generated.
> 
> In order to avoid too large values for 'o' (and potential negative values
> for "sizeof(linebuf) o") use scnprintf() instead of snprintf().
> 
> Note that given the "w < 4" in the for loop, the buffer can NOT
> overflow, but using the *right* function is always better.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to for-6.6-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

