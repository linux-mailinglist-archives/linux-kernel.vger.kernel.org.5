Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1070775B226
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGTPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjGTPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4D2127;
        Thu, 20 Jul 2023 08:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A17661B38;
        Thu, 20 Jul 2023 15:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A1FC433C8;
        Thu, 20 Jul 2023 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866071;
        bh=GJYbKcpY5i1rE3HQg7v+Z0rHq1dJgc8tAI1aT38vmMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xzj4A5oZjfZR1QlwF1j9ldcfFMKATVzsrZm/jGEhjiw58KbrNq3L6MrwNQKBzbxLD
         2ZMSL8A3Q6mqnYzuPeCrBPk3H4ewOycuPJD2DrSQ9Zory3j4HEgnloBzwbOef8Zr/q
         /jose9HirYNlxyG863K1/sLIAmGe6wtKWrYSnPw98khHTj8Kq8aR8Qhpx8EIIPvDTK
         Df5xxnH+NsmIfK31+NRJnfJM0FbFeXSd8dLPcj9TkdVV0lcZ3pwuwtXuPeIKQSVrgA
         LP2YVQNGyS0pWa2XI7bdHw+Hqz1XojNyt/xW9zoOo9tQIANcwDwGojcIJbn5uLDzNN
         OXJkGk302y6eg==
Date:   Thu, 20 Jul 2023 08:14:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230720081430.1874b868@kernel.org>
In-Reply-To: <20230719202435.636dcc3a@kernel.org>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230719202435.636dcc3a@kernel.org>
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

On Wed, 19 Jul 2023 20:24:35 -0700 Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote:
> > Sorry for not replying inline, outlook on android, we use scm_recv
> > not scm_recv_unix, so Id assume that change would return the initial
> > behavior, if it did not then it is not fixing anything.  
> 
> Ack, that's what it seems like to me as well.
> 
> I fired up an allmodconfig build of linux-next. I should be able 
> to get to the bottom of this in ~20min :)

I kicked it off and forgot about it.
allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S
