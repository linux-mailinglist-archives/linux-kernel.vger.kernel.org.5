Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3627ED558
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKOVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbjKOVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E726A4;
        Wed, 15 Nov 2023 13:03:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC40AC433C8;
        Wed, 15 Nov 2023 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700082199;
        bh=6iFkJ9CgOv8m2X+1Em1JMHhqIxyCZ6Qr3KSR13K3huM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dk4rDKxA0ItonubvGbIA6kOO4BQ/BxPKjEvuouQ3hBwft2YkQ1nM8EsubAujp6Rll
         VQaazriqth98JZ5XQk4K445Cepsy/FFEEQtYHDk8BHOyYDld+Td8jFeNHEVz/4ivWG
         G10fsUCTYPwf1EdKr2k8W3OJA0M2HQ3RcH0cK1eRdmk64soo+BxuEGzvc+y3rqtfc4
         hvOfAiGuGJp1BLqlUGtvB3lx3ayVs0StPc2jMLgduP9fgOPWv4pIZdjPnoat+PBRaa
         5x9z1UMoJaM3aG6Uz3G8Ne3GiYZWuMktXisQ00FWOK1UdPTvlb6+4swpdwJyRr6KSq
         GE5BnVtzL+Qpg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:03:13 +0200
Message-Id: <CWZOU9WPLL2Y.30QYCUBCE0UQA@kernel.org>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Julien Gomes" <julien@arista.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-4-jarkko@kernel.org>
 <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
In-Reply-To: <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 6, 2023 at 9:31 PM EET, Jerry Snitselaar wrote:
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks.

BR, Jarkko
