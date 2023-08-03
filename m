Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3346576E3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjHCJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjHCJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78293A2;
        Thu,  3 Aug 2023 02:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C958619E6;
        Thu,  3 Aug 2023 09:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3289DC433C7;
        Thu,  3 Aug 2023 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053612;
        bh=zYWE354MAafuiasDmJ86KbFNwkZpL/yJwk4Uz3jnHf0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ORFzZyIrEfxhkCMcO/abwF4GdFezQlQCFLCxYDK9gV1oQNTsHE2zdQ8HrMN7YYbpe
         XsL71eW9kpV4xam7Co4moLAhi7B79l1SUIhf0eTFuZvfZlqMNR1dT36ZGObFHQhk2d
         H9HqfCyfCliTLTzWjJZXuH5nSovw5mKBnINFPahyZKCgevJXCQ0vDGMXhQFdUZ+QZ/
         P4wfg5JHH4hNfVKuISNzw8xwZXh9kTR/AQxqEDZ/y7cLR0Q2MpoAtvyUSKCF5MBgaJ
         OCx9eVPsdRiTmwD/zO2m8jhMtsq8CWORnoDBI1Lov+LmRx416m90eG+Tn1vbhKS28R
         +d3im+v8/hHSQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 12:06:46 +0300
Message-Id: <CUISH28XXJGN.EWZ3CWAQ7G1C@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: boot-time vtpm helper (was "Re: <void>") 
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <CUIRLIY5N6CI.3O9UKOY2N5BS7@suppilovahvero>
In-Reply-To: <CUIRLIY5N6CI.3O9UKOY2N5BS7@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 11:25 AM EEST, Jarkko Sakkinen wrote:
> Hi,
>
> I have a working PoC for boot-time initialization of vtpm inside
> tpm_vtpm_proxy. ATM, it uses the Linux firmware interface to load a ELF
> binary for the vtpm, and delivers a communication end for the helper
> process.
>
> It is a great feature with the current narrow scope for continuous
> integration. Obviously the scope could be later on extended to e.g.
> from unencrypted plain text to a vTPM living inside SGX enclave.
>
> I could send an RFC of this, if there is wider interest for the
> topic.
>
> BR, Jarkko

I'm sorry, I'm trying learn aerc, and unfortunately forgot to add a subject=
.

BR, Jarkko
