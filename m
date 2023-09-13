Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3E79DF62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjIMF1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIMF1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:27:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F412B172A;
        Tue, 12 Sep 2023 22:27:14 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 2B049212BE43; Tue, 12 Sep 2023 22:27:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B049212BE43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694582834;
        bh=Wf3IR5Rw+P9N8xEXtP0JOGbFUququkZ2xKLTTFywNE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0OS1U2wu+nD2bfTE7KyChF5Q+6yfMPXgNwDBGYxTY365OYF7iEtIeiaBkjs74DSe
         kfrFScGaycfGQnUMkCWONgLPuxVZkoXgzgb+wnanBzaiTZn0aItzbzPIiMyyGTkC6T
         8SOvc/BkgtSwaBdQWNJlxCY87ZddNQf7cgWjGlK0=
Date:   Tue, 12 Sep 2023 22:27:14 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Message-ID: <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
> > On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
> >> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
> >> non-Hyper-V hypervisor leads to serve memory corruption as
> > 
> > FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
> > platforms.
> 
> Fair enough, but there's really no excuse to randomly crashing the
> kernel if one forgot to RTFM like I did. The code should (and easily
> can) handle such situations, especially if it's just a matter of a two
> line change.

Thanks, I understand your concern. We don't want people to enable this
flag by mistake and see unexpected behaviours.

To add extra safety for this flag, we can make this flag dependent on
EXPERT config.

- Saurabh
