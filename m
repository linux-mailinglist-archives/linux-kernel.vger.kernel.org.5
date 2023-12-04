Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B598039D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjLDQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:12:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70815A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:12:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703B3C433C8;
        Mon,  4 Dec 2023 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701706343;
        bh=MBDQUUo2JUiiYc8FoOPuMioHnUJ1IL95bAxMP6fsTc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=maFYKgAy9vXSF6Gy2o1GLDwcHNcLaKj1Jc9FvTqK2Mxc+/o0ynF09qajAtMn87IO2
         y8e0jAZP9PNAPyOuEb6iYccjK9DF9BmVvucMIdTWHxWwaiDr6iEtWNLcTsvs5NOteG
         omn6p9mW7JuH7d0XlpAaINdmmrgX63Vv7HnY8KrAVPhtW2aYkxvsw8qceRnFPZi+Oe
         lM0dQ783jRTPCu6nevIiSFn8Pnb1vQyLlqPrUM0KHBEgS99admyMNrGsAfnBlvbo9F
         AHelvpBw3OUD6fpdpDmCE1fe0R+0XmAm6AY7bsQ+k8rsDSfDiDG5ZPrllg4eOsrb7y
         ZgZE8c/CMopGw==
Date:   Mon, 4 Dec 2023 08:12:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20231204081222.31bb980a@kernel.org>
In-Reply-To: <CAA8EJpqGAK-7be1v8VktFRPpBHhUTwKJ=6JTTrFaWh341JAQEQ@mail.gmail.com>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
        <20230607094922.43106896@kernel.org>
        <20230607171153.GA109456@thinkpad>
        <20230607104350.03a51711@kernel.org>
        <20230608123720.GC5672@thinkpad>
        <20231117070602.GA10361@thinkpad>
        <20231117162638.7cdb3e7d@kernel.org>
        <20231127060439.GA2505@thinkpad>
        <20231127084639.6be47207@kernel.org>
        <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
        <20231128125808.7a5f0028@kernel.org>
        <CAA8EJpqGAK-7be1v8VktFRPpBHhUTwKJ=6JTTrFaWh341JAQEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 14:12:12 +0200 Dmitry Baryshkov wrote:
> Ok, here you are talking about the control path. I can then assume
> that you consider it to be fine to use netdev for the EP data path, if
> the control path is kept separate and those two can not be mixed. Does
> that sound correct?

If datapath == traffic which is intended to leave the card via
the external port, then yes.
