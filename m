Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224CD77F80D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351551AbjHQNqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351592AbjHQNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:46:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0B210D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:46:36 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692279995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTQFDemPIBWi9jy3PXFyN0C6IeR77vsLaflv6DSzCvI=;
        b=w1RH2yCogWTZsNnKHi/g0ALIBufJLQoLKPtD/nhM8/EoSS3XipnkWNyEqPhV2qpLqEXt1+
        nYVD4kY6j+MPAe4yE6FaXqbBYGbhfwVwW+U0fxt5kI0tAshAoS9fzokdoORXrDpwC5Eoxh
        NQV7iEWyRtvcQjQmkArmRY0hcoR4TvFuEqOGUUKtLy2EBy77OWrJJMssnP3sYqm3taqPde
        c6nqoPAu44sOPmhgZaehhskTViukjbBqASEpVfpgrUtwWTQYDjWyCiD/uVXDhB0kqJyM68
        JhWdSdqQL35ZOrJoc5Z+/rEWxEcbiNmJlOfrpJ8bThVmQWlk1t5xFFPOcNjspw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692279995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTQFDemPIBWi9jy3PXFyN0C6IeR77vsLaflv6DSzCvI=;
        b=UJbbx68eR9y3g9PPbp5TcCZm1RcLtnjRzEuiGkgud7nQezgY5la4xY99l/4PgUSa31ppDs
        pTP2r2utrQLyKHCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST v3 0/2] signal: Avoid preempt_disable() in
 ptrace_stop() on PREEMPT_RT
Message-ID: <20230817134632.jbAX7yo1@linutronix.de>
References: <20230803100932.325870-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230803100932.325870-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-03 12:09:30 [+0200], To linux-kernel@vger.kernel.org wrote:
> this mini series updates the comment to properly explain why the
> preempt-disable section has been added and then disables this on
> PREEMPT_RT explaining why it can not be done.

ping =E2=80=A6

> v3=E2=80=A6v1
>   - Include the update comment of the second patch which was posted as
>     v2 within the orignal thread.
>   - Add Oleg's Acks.
>=20
> This is the repost of
> 	https://lore.kernel.org/20230615105627.1311437-1-bigeasy@linutronix.de
>=20
> Previous post:
> 	https://lore.kernel.org/20230606085524.2049961-1-bigeasy@linutronix.de

Sebastian
