Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22457829FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjHUNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHUNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1DD8F;
        Mon, 21 Aug 2023 06:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B1D608C1;
        Mon, 21 Aug 2023 13:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA4C433C9;
        Mon, 21 Aug 2023 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692623369;
        bh=Ue4PljFX0Y4Wr+hL9N2lXfScZ11b5NsaCOwr1YY7C6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5vc4t/Qmjma4sEvZnDvWHSjEk94c1Q0n8mxurxAalwP8+yrnNBRfGG5orb+Vee/z
         AZABOr2aKTezWX0SR4f+4pRDnzJ/xCxw5tucpGpNwayULKqtX5dFcVdP70+mz6xhwy
         N4b4V1ZjFMkX/RC1eqGqwyFR6lUtkmVKpwp1vAY4=
Date:   Mon, 21 Aug 2023 15:09:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Backport unlink misfit patches into 6.1.y
Message-ID: <2023082118-slot-nutrient-990d@gregkh>
References: <20230820191650.532978-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820191650.532978-1-qyousef@layalina.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:16:48PM +0100, Qais Yousef wrote:
> Decoupling misfit from overutilized better helps handling misfit due to
> uclamp_min only being misfit without triggering overutilized state, which is
> bad from energy point of view as it prematurely disables energy aware
> scheduling.
> 
> The series also makes the search for a better CPU under bad thermal condition
> more comprehensive, which is useful improvement when the system is under bad
> thermal condition.
> 
> Backports to 5.10.y and 5.15.y is hard as find_energy_efficient_cpu() is
> different. But it applies cleanly on 6.1.y
> 
> Compile tested against various randconfigs for different archs.
> 
> Boot tested on android14-6.1 GKI kernel.
> 
> Based on v6.1.46
> 
> Original series
> 
> 	https://lore.kernel.org/lkml/20230201143628.270912-1-vincent.guittot@linaro.org/
> 
> Thanks!

Both now queued up, thanks!

greg k-h
