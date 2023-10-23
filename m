Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A287F7D3CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjJWQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjJWQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F646D79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E8C433C8;
        Mon, 23 Oct 2023 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698078816;
        bh=iatCpzjSjYhZBmCgGmBhqgE2u8WzpQ+9KXZYbkYH6LQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/HTBh299ChYxhImN3R8po4A50IGmUBXFUp0rQbWRjKNjZ5SIKyOPMRp6wwCMCnNi
         wDJ/vz8nfIV3ZBzUwBkx+LR4Xg0fdvQXur968aEmQNNhT0db8KCdBqL6lmgRlSRG7c
         KeoFEYZF/RZE9NFdaVCFnfUG7JKB3/+UsRzLwTly6sBlDj3p1T6zpKC2ptp/9teQWb
         uiOoiAbpo6vuNjssck+2cDWlRRNBo87iLC7SzC+MwxEFmdRlrAFdW8EIBZX59Q2eC0
         P3rNzcF1qYd+VN+tRWycVvCjaNn4HQ5poKUWDE31vsoFw3gHDAEbqautrWaLDwI8IO
         8ub9narOYRtdA==
Date:   Mon, 23 Oct 2023 09:33:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     wojciech.drewek@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com, richardcochran@gmail.com,
        syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] ptp: ptp_read should not release queue
Message-ID: <20231023093334.3d6cda24@kernel.org>
In-Reply-To: <20231023095549.719099-2-twuufnxlz@gmail.com>
References: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
        <20231023095549.719099-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 17:55:50 +0800 Edward AD wrote:
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>

We need a legal name for the signoff, not initials.
