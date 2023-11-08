Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4747E5F48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:38:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B96210E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:38:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26D9C433C8;
        Wed,  8 Nov 2023 20:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699475881;
        bh=r/rgBWul9TKz/9RQBIANFTJP7LLteWn6RDHDicGjfd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvucthBH0ksB7fwkkr28pVIvJjcn+pdTAHNZKuN6bhCQC0yqWXS8fsNJ3KrajM1cM
         3vKeEeVxk7/amJikhzZejFp9VuIRxqken0SBAA8+3WLRYUSwlml2C5OnhOc7uIvLEw
         LPri22Cp9QgUQn2pUa7YzblfoAZNr7j7tMq0mIhCE+VxtqVQeiACCboDMzzlpdv5D6
         mvQXpy0ewvNlW9d0vKgR3H48myN5AVgZiME+pkyn2kib8HFL2k133oJsucW4vXuhnO
         Q664DIKMg7ddQjqxdL2s9KKGQx43YNSBlsMb1f+p2cWnAkKBPU5+o2Te1uA9Urt6B/
         M5KZ5iJQvN/9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80CD54035D; Wed,  8 Nov 2023 17:37:59 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:37:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 PING] perf test: Adjust test case perf record offcpu
 profiling tests for s390
Message-ID: <ZUvxp2IgnS9VjNjR@kernel.org>
References: <20231106091627.2022530-1-tmricht@linux.ibm.com>
 <CAM9d7chpvhDCkTLiuPVqSKxoZdNYgJ0A2HvVdXbEgMvPZrv1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chpvhDCkTLiuPVqSKxoZdNYgJ0A2HvVdXbEgMvPZrv1Eg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 06, 2023 at 07:21:35AM -0800, Namhyung Kim escreveu:
> On Mon, Nov 6, 2023 at 1:16 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > Lower the number of expected context switches to 400 to succeed on
> > s390.

> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

