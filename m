Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755AC77B533
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjHNJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHNJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:10:26 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3C12D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:10:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0456840E0140;
        Mon, 14 Aug 2023 09:10:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ywYhGo1x0Gi; Mon, 14 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692004221; bh=Im1/DAa4v2T1osa4p05t93MBfqN5gX0V3YHLAWBwOxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzRO8lyYgrK1LU2VN0srN+httcc8cpVR7jcR+dd8nahECp7dvVbJN/XunXy74YwO1
         ZkKKYy7IdMiMNoJ1XB8mmjl6EUouMr51QAVYxV2E2YVaMxsqILErslcIsbWcELiSDQ
         16mHpQX5sT70mTMnpfg+U0XN0HHXZNECU1Ov9UyBeUvwdL5Sf/01ewFEBWWxaoAYCX
         Ox2cZy8tdWUAqYU4ZeYUUs816M6un1BhnUKoXDGgJ/lTT5OXBLoRdJvpeXtHGDSmGC
         wHnEQmhfCRwqA8byqXp/gc6WQpS0oaJIVgGS9mm9EQTuRgvxSYZzZSHmM5wJ/rV/6c
         +dE41i25O9EhKHetnPGevz9TQblgNX+nc9+EAsfMvoNgNQZ/igXEIZ0TK+7tEznBZJ
         lNwq2TbEDd+PzArPb4TZRDXO2vOPKmzjUqUKCWhmT6HV2s/L/K4LdD6AmyltQf3hFh
         pfQ5T+P0biqpkjTGnbtUIw1+sbysHh+Dyj4aaH30G3glY1MHSu/MCTbgdn0bjFHQHi
         tgsZzlNOb/jqo8ZvFbDGsQMDKvVM9mzJyrMDbHysnRn57kX11CL9gxz9ZMv/SfnkqV
         gd28Q3MKouXQORfIMup/6Yk+YQeyMTvy09REn4A1S5qKDrSQqKjnA2l3F72wMM+ymZ
         vVoBP9LwcprFmbeTo+z4rOzc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CBD2E40E0185;
        Mon, 14 Aug 2023 09:10:17 +0000 (UTC)
Date:   Mon, 14 Aug 2023 11:10:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Rainer Fiebig <jrf@mailbox.org>
Subject: Re: Does srso safe RET mitigation require microcode update?
Message-ID: <20230814091012.GAZNnvdD6JX/4E679D@fat_crate.local>
References: <79c179acaa6ec4e1cf112ae2dfce8370694a5089.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79c179acaa6ec4e1cf112ae2dfce8370694a5089.camel@xry111.site>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:00:12PM +0800, Xi Ruoyao wrote:
> So we are puzzled now: is this system vulnerable or mitigated?

Read the whole options text here:

https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html

Does it explain it better?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
