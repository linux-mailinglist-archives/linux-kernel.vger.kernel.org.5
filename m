Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA37F6A39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC6D5A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:42:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1749DC433C7;
        Fri, 24 Nov 2023 01:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700790153;
        bh=meA6zEVLAnIoCnnApPSUpa0M4STnpaOaSqjkHxeRhuo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=G37l3aM7IQU2UiaZFLasyIGu1aioj1geosiBZVr30RUGy9WlaLO2MnZWVPbBu2mu+
         hQGGvdxhA4iYIBmLcpIxalxIQe0GN18jPPotMDxZObH/kKyPjr5zCvupoBgJNfD/Nd
         0meFHu0JU4YwyWttSZqkTJH7PU4G/LyKR5gymwy/ZVnN3Q1Bv/2DmBg4ywnx5q58HL
         3T+wp3BTnjuz4dYlX+yXmRBtSjbb8i9QVx4ONSbwsXsAtCqKs2QOhpD/IagMkFUZmn
         E8WvirnzX5LNJ3z6dfmVjY+EFQiAR/+Xp3eLxaqtDzSzBnfi6Lq+EtqCboTFqqwojY
         lI1cnBfiu5PIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 24 Nov 2023 03:42:29 +0200
Message-Id: <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Hermin Anggawijaya" <hermin.anggawijaya@alliedtelesis.co.nz>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
In-Reply-To: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 22, 2023 at 8:55 AM EET, Hermin Anggawijaya wrote:
> Before sending a command to attempt the self test, the TPM
> may need to be started, otherwise the self test returns
> TPM2_RC_INITIALIZE value causing a log as follows:
> "tpm tpm0: A TPM error (256) occurred attempting the self test".
>
> Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz=
>

Firmware does TPM power on.

BR, Jarkko
