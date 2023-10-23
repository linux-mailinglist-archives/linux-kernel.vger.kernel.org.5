Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5957D2CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJWI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:27:25 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4EEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698049641; x=1698308841;
        bh=E286vjDkg1qT5X7T/0laoU76NAczw6eMVxOaqO74GTQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HHqC6H6jpKuOnCR6UjEuqgPw8HVmDomNFEobNYu+lQdncQxP4VLHQAjmGEA+bP3JN
         /alAi8MHa8bY53QoR2e1GKCaid6zWfgJQ+vyuOgmcxYKvZBnb0wo70x4GpchHpV5WF
         gLLiDhMjvtrCAOOB8njQEhf9Cognaxrh1MnAaFtfbIaV4fB1Id/cFu9LlgpKeMrXmv
         /vfcR4UpV07Th843zJRGjOhiUU/l3bvr9zYY4eHu0pWKfFwwwsR3OkFhP4pYHIKLIX
         hGvoVr+bUNkIN/P7QJUSDgMBtmziBgP1BPc5+EAJEfL0gL6kDqk49KB60pc3pObzf3
         q0IQlLjyA2w/g==
Date:   Mon, 23 Oct 2023 08:27:17 +0000
To:     =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <Bi9El_nuZXA997YlVyCzD5s7KfP820IVUuYiB69mgXnjQbfCgOucCBe6aKvSFrMzB_9DwxO2lli_MqLzMuGZ-rmrRp57vePsTwUarEweLJs=@emersion.fr>
In-Reply-To: <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
References: <20231017092837.32428-1-andrealmeid@igalia.com> <20231017092837.32428-5-andrealmeid@igalia.com> <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr> <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr> <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 22nd, 2023 at 12:12, Michel D=C3=A4nzer <michel.daenzer@=
mailbox.org> wrote:

> On 10/17/23 14:16, Simon Ser wrote:
>=20
> > After discussing with Andr=C3=A9 it seems like we missed a plane type c=
heck
> > here. We need to make sure FB_ID changes are only allowed on primary
> > planes.
>=20
> Can you elaborate why that's needed?

Current drivers are in general not prepared to perform async page-flips
on planes other than primary. For instance I don't think i915 has logic
to perform async page-flip on an overlay plane FB_ID change.
