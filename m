Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E867CC21F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjJQL6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJQL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:58:04 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5169B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:58:02 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 13:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1697543873; bh=osOPrqiiKOprJxC70XFTAVq992xL7ZaM2aZVaEQG2Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnJgpiNWAMGVc0xEWtD9K4S88LSSPMbgijDz2pOHmBktW2Orxe1PlrhnLTDsBrgGX
         tfFz/35yEpjsd2lWXJB3L8dxOM1f2ywcRKM8oZxaKD9ofLnmAeJI+8zMVH6ERwT4HW
         LewlwUwa8Y743N4nthnjDBYgG1826/sWxFei++6o=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 1002280683;
        Tue, 17 Oct 2023 13:57:54 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 0841B1819FD; Tue, 17 Oct 2023 13:57:54 +0200 (CEST)
Date:   Tue, 17 Oct 2023 13:57:54 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 2/2] kbuild: unify no-compiler-targets and
 no-sync-config-targets
Message-ID: <ZS52wrL9meW8iehZ@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
References: <20231014105436.2119702-1-masahiroy@kernel.org>
 <20231014105436.2119702-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231014105436.2119702-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1697543872-187BED95-BE924DB1/0/0
X-purgate-type: clean
X-purgate-size: 416
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 07:54:36PM +0900, Masahiro Yamada wrote:
> Now that vdso_install does not depend on any in-tree build artifact,
> it no longer needs a compiler, making no-compiler-targets the same
> as no-sync-config-targets.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Revive need-compiler flag
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
