Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756237F336E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKUQP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjKUQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:15:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A6192
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:15:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478BBC433BB;
        Tue, 21 Nov 2023 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700583323;
        bh=GkJN6hJwY0IEsFz7BKwOr5uoLUCm7aY7Ss1OnguqbVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcPyiw/LekP14xSMdqxxkRSbDt4V0bjZcTxCsAREQbejJEya183Ksc3TWESmWAGYj
         vIPQkJZA4wJPqoQNsg1p9hiuAHZ+XxV/8ikh8loDBxe92L/qpgtvCUlC6C2xQU0U5p
         GfeKtpAi30IrHuoC0zIP1+qfeeDAWI044/bQ9EVQyGwKgXwKdWNgt6005pCDtY8uV5
         YO7C8THNQYbuKdru1O2GKDCL0c/s9C0qbvT/ty5oHtCfFu/giDax2WMuPeIX+xmLqY
         7vwdvkh6uZvCok59a6/EGzZoDp+EEKkGtMVuTyur6ej0fOPJZxSHaPN5AK3kqgpYov
         JfIaHLTlASZUw==
Date:   Tue, 21 Nov 2023 08:15:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Message-ID: <20231121081522.6ea6969a@kernel.org>
In-Reply-To: <20231121114831.3033560-1-leitao@debian.org>
References: <20231121114831.3033560-1-leitao@debian.org>
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

On Tue, 21 Nov 2023 03:48:31 -0800 Breno Leitao wrote:
> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.
> 
> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs input file and generate the correspondent RST file.
> 
> Create a new Documentation/networking/netlink_spec index page, and
> reference each Netlink RST file that was processed above in this main
> index.rst file.
> 
> In case of any exception during the parsing, dump the error and skip
> the file.
> 
> Do not regenerate the RST files if the input files (YAML) were not
> changed in-between invocations.

I can confirm that it does what it says and incremental make
htmldocs does not take forever.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
