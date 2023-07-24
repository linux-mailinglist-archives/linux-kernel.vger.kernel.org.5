Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CEA75EF06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGXJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGXJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019E122;
        Mon, 24 Jul 2023 02:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E79F461005;
        Mon, 24 Jul 2023 09:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9505C433C8;
        Mon, 24 Jul 2023 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690190572;
        bh=LnDt7R7jTXpWTe6bODtY9gDITIrapEEFQ0ZVh17zgK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uztC49EA0tnh8I9TcWEVXOgl1OohWN/sr4mqjrDFUc2OTpprHSfvgFz1j3L4px6PB
         OUJxuGokiM3RlFg4qq0dpTAklHWMDkzU7L6qZQXErg321siY+LDTI3Z0ssZvxU678J
         1AArjGHr1FOhubynN7Gv5iHg7MYTjQNJG+WcbvuI=
Date:   Mon, 24 Jul 2023 11:22:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Franziska =?iso-8859-1?Q?N=E4pelt?= 
        <franziska.naepelt@googlemail.com>, linux-staging@lists.linux.dev,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Emily Peri <eperi1024@gmail.com>,
        Guo Zihua <guozihua@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v4 1/3] staging: rtl8723bs: Fix space issues
Message-ID: <2023072440-dimple-slicer-3fd7@gregkh>
References: <20230701102538.5359-1-franziska.naepelt@googlemail.com>
 <5ad04b3a-7c77-cadb-13b4-509a086cf04d@web.de>
 <2023070123-unburned-worsening-0713@gregkh>
 <CAAUT3iNqwgtFJz2Q1bRN+MsSna26KC1FJc3jchu=8B09A2SkvQ@mail.gmail.com>
 <4b9fdaa7-bdcf-ef41-0d54-ba41520cde4c@web.de>
 <CAAUT3iPUaNRUyvqP1O97M0AmKri7Ghc06ku4TS6vcHQ=Sb4ycg@mail.gmail.com>
 <67b16362-aace-28e3-6776-aefdeab0f183@web.de>
 <2023072453-steam-scotch-bc17@gregkh>
 <c6374bc6-2a56-23b0-6ef9-def092aaed4a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6374bc6-2a56-23b0-6ef9-def092aaed4a@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:44:15AM +0200, Markus Elfring wrote:
> > Everyone please note, Markus has been banned from most kernel mailing lists,
> 
> I hope that this ban can still be reconsidered.

At this point in time, sorry, but no.
