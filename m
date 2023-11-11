Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18697E8BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjKKRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:44:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350E3A81
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:44:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23891C433C7;
        Sat, 11 Nov 2023 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699724677;
        bh=6Edi0vC9LiOgbsxo7Eus18euFKTCuNPbb5omqvA3nIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0LfvHwwqV91pqUaZR5D96C/DUoNEis+eOARQ0Xgo0xy5aZNDZZuJdWIZDcwbiP6B
         qeqhm3w+sQPudByElpCEYTv86EmHFa3eq+DBgp3Vq6bqCdpu7fnUs08NRmmzlAjJtT
         DwJybcieV1EKhXwAJzKJFXa7LxNNHot5wL/Qy7hJW/ng8MzDfhFgCh5/z6OH24aSo1
         UYqU4tgm2Iemih3nAIIU+YfX7fH/42plr0qBg7+v9BzDY1nayemfduvJ9W8YU2T03n
         dBagxMEFrwONmbcLz9LreJwMDub/X5lYyZ3tG2ecHa/8tHxRI9K+d9DgX2QS4yEK0j
         tV4v1mfzeeHqg==
Date:   Sat, 11 Nov 2023 09:44:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20231111174435.GA998@sol.localdomain>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-7-ross.philipson@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 05:27:44PM -0500, Ross Philipson wrote:
>  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
>  lib/crypto/sha1.c                       | 81 +++++++++++++++++++++++++

It's surprising to still see this new use of SHA-1 after so many people objected
to it in the v6 patchset.  It's also frustrating that the SHA-1 support is still
being obfuscated by being combined in one patch with SHA-2 support, perhaps in
an attempt to conflate the two algorithms and avoid having to give a rationale
for the inclusion of SHA-1.  Finally, new functions should not be added to
lib/crypto/sha1.c unless those functions have multiple users.

- Eric
