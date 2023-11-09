Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18A7E6E51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjKIQMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:12:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D703272
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:12:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7460DC433C7;
        Thu,  9 Nov 2023 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699546353;
        bh=6v3NZwIXeiunZoxLw/nLe+B/ljE9jHx11AxZVwEeZIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqpM2CzMjXJ8579OjnqT+tlDsQhsLII1MxWXzO3ojmD+kKs16Gdrs+JjtfOsOV9pS
         qnK553mRiPSU9wQ4RUhO0s0pMD+8412PyLhb2WrZVJgIONiIlYJsGo3RnVoqmCSlZi
         dNbX80/EzXDNT8g1pcFnhhUNyu2J/k4tAk+v1+vIk11nB7SwkhYmJZJCBeMZXANC/N
         /OIkN2VesMkqtSvTKjg0y+xvruGXELyNn24GL3R88CLBVsuNusuNP2rxVYUfGQZYlm
         PXTAavo4hFwL/oxX7/Hvn/MOyTXYtzWE3YR8ExsMDfRtaRvvRg7le/pNO8UhGhxVBP
         FXy9XvoFSEiJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9310240094; Thu,  9 Nov 2023 13:12:30 -0300 (-03)
Date:   Thu, 9 Nov 2023 13:12:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZU0E7j5UJn5ecCAT@kernel.org>
References: <20231109124105.3845355-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109124105.3845355-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 01:41:05PM +0100, Thomas Richter escreveu:
> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> added support for Processor Activity Instrumentation Facility (PAI)
> counters.  These counters values are added as raw data with the perf
> sample during perf record.
> Now add support to display these counters in perf report command.
> The counter number, its assigned name and value is now printed in
> addition to the hexadecimal output.

Can someone with access to a machine where these counters are available
try this patch to provide a Tested-by or Reviewed-by tag?

- Arnaldo
