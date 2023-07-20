Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D375A4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGTDYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGTDYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3192;
        Wed, 19 Jul 2023 20:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEBE61254;
        Thu, 20 Jul 2023 03:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2731C433C7;
        Thu, 20 Jul 2023 03:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689823477;
        bh=YulX0mO1Z33K0iP33Q6hZ0nrby/5DziNCqkBxAomqlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S2UjTeYlrDpe9TC+Lgr1Fg5KFP2vZ+9jQRACUsdu/XUBWPj/fNOJu/irWZNDKxOk3
         mdp54V0U/oWj/nbOauh7lwdzTZQ0i5MLK3Smd9qaPByyN1juGK537kLyybZKHQFpJ5
         ve9O8MqDfhlKJFbuGsnqFjdKCcxmu60hvFsyjBUANWDbGrKO9QRc5Hg45jU9nRsCC0
         ZMXm1wUhgfrI8xkHpxUslhkPmseG1nsns5i0X8V3RcKYVzwWifrEdI0usK9gGrM2U1
         Nyxi2rma1sZv8GFKGr889q9LOS6F71wboyCt5Wm0Z/QciUfA292KzSRVJB06WTaLO/
         /gP/c53XpwR7Q==
Date:   Wed, 19 Jul 2023 20:24:35 -0700
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
Message-ID: <20230719202435.636dcc3a@kernel.org>
In-Reply-To: <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
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

On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote:
> Sorry for not replying inline, outlook on android, we use scm_recv
> not scm_recv_unix, so Id assume that change would return the initial
> behavior, if it did not then it is not fixing anything.

Ack, that's what it seems like to me as well.

I fired up an allmodconfig build of linux-next. I should be able 
to get to the bottom of this in ~20min :)
