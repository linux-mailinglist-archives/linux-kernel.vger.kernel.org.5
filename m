Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C47E7E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbjKJRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjKJRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4CA753F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 05:33:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966ACC433C7;
        Fri, 10 Nov 2023 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699623231;
        bh=zeW97rNRPUdz+KuoHgAUP4bAl5sLNJZUkAnGoySTVis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W76exGFUQZVYHtt2nDGBJCNCpc4Bl8ZDBvZOidYVy1MW5SNiWLn1KsoCyEAF+4S6m
         NxuRfwRf4lkdtMEsAvz7sJF/8JXSgvCMt2HxRpCwOmYuM0/F+YAz7tmHckSbsj+Jf4
         gCgj6QxlI1m4vaV1lkzecaW0zUxdY7QoORGk4AVOF0OnoNmq/wnmfZxieDai6visH0
         cfcWfW64eNMb72KNpSKG6JY7PvItjBnWQCXBdYbiTrlsftY5gortmJxjE9zpRpGnc7
         A9qFezwplvd13muYNp+vTrxY9hRBH/R8thjrF8duvaptf++jvrlxMHCHAG98Hz8mvr
         a8D+Xywi2K9lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6ACBF40094; Fri, 10 Nov 2023 10:33:46 -0300 (-03)
Date:   Fri, 10 Nov 2023 10:33:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v3] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZU4xOmhlT5IQlI2O@kernel.org>
References: <20231110110908.2312308-1-tmricht@linux.ibm.com>
 <ZU4d0G23WOKwpIwb@kernel.org>
 <6d5a8310-d3e4-4fa7-8103-b50b100e22f7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5a8310-d3e4-4fa7-8103-b50b100e22f7@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 10, 2023 at 01:31:59PM +0100, Thomas Richter escreveu:
> On 11/10/23 13:10, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 10, 2023 at 12:09:08PM +0100, Thomas Richter escreveu:
> >> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> > Where is this commit?

> > ⬢[acme@toolbox perf-tools-next]$ git show 1bf54f32f525
> > fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> > Use '--' to separate paths from revisions, like this:
> > 'git <command> [<revision>...] -- [<file>...]'
> > ⬢[acme@toolbox perf-tools-next]$

> > Looking using the description I get:

> > 39d62336f5c126ad s390/pai: add support for cryptography counters

> > Is this the one?

> Yep, I apologise for the cut & paste error, this is the commit number in question.
> Should I reset a corrected version?

I can fix this up, thanks for confirming,

- Arnaldo
