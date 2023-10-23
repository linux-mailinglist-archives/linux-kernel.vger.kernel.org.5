Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D777D38F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJWOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjJWOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:07:13 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EBCC;
        Mon, 23 Oct 2023 07:07:10 -0700 (PDT)
Message-ID: <b8e37bfc992532038f9d562f5596cbf3.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698070028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSfE4hORG5Bzst26B7/qFOcc4kmlRNLkRDCUrI5g4lM=;
        b=R/eh6H29weLnIvT1D1BzpiD4xSKUHOnLDjToKZODoxIIpghfBMZJDQGtgb6LHdfbNBUnRQ
        0T2HUTlZ9pCB6VV3kpGA2wN3wShu4M1cW0JhXGcQ+SDYCIhtFZ6Yi5piuiQW9UfVUzHPgs
        3bQsql4Uwc6MwcswUsCKgLojKk2rG3UeTHgC+elJVdjFx3MAUpK4YQJgGmIx09WtSOhRfl
        TmUoWvndhMK3B3FSoRmjTanSaRHXpWOVVWI2MxKkTnkrNF6WU7h57erRnuDGdULD0QW97l
        cri0YnFFsEfRa4wdi/8ixseE39NLQIxV0CfjI3MWEDImfUoC1IKfKXCE3GOImw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1698070028; a=rsa-sha256;
        cv=none;
        b=G8AJmOZ03AuCgY4HtmnxgHECvGLV7G9XNqAzCuohuAt8tGRd1ucBdvOO/QUWo3EvFjHL9L
        x43mZXL82Atu6HWjeHb7pWcfDyMHJUk5aCXiuBFFu0wBIF4X2u1UBFKpdo87wSNIeSydip
        0jGa+Mj/VOJ4NbHsftppn8yTX4SLFE0cl5BwZJQpdxt60RI85z+PKB+R+YKEoO+DpCvaoG
        QkrmiQixG3DzLGMUJ5SMh+5Pa+wImxZjdhtuAV+eFV6QGRB70k8/7i3SvkXQD9I6RUa45E
        mWR7mhoQvFk99kyFMYjo+xNR0yYPCHO+JldfeSFbALsAojbgkCdfgZadrlqtaA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698070028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSfE4hORG5Bzst26B7/qFOcc4kmlRNLkRDCUrI5g4lM=;
        b=c4p4K4a7lNTqPnjWqZywQUxMMmNipxxDjCIRLbWcKZrMgVEy/zyX6yIcFN1b7wcA4fzxPC
        vnJusKqOwmvAynEGqxiKRDhsTtGlMiRUqJ+NU7twuXzBDka0xI8HDW1qvg4vbEyTYvV6Ai
        IwQlO0kUtFZ+WwRaq6+1mtweRgaTfMVxFnJ6z63f9vHj+zcxVGP5jG2l9CXvzW7qz2IJ/r
        dj6gHPtuccpy8zHWAMhc2v24bRVrbbCnq3OrMqE/XfS+uKMSimetWaq3veu03ptrL0Jr+c
        SFm0WyRHI+VZGIkZQTiY4aPheq77nMeIcHyRGWDRGb0WbpPUXhzwwi20qbo+2w==
From:   Paulo Alcantara <pc@manguebit.com>
To:     "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>,
        "smfrench@gmail.com" <smfrench@gmail.com>,
        "matoro_mailinglist_kernel@matoro.tk" 
        <matoro_mailinglist_kernel@matoro.tk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "paul@darkrain42.org" <paul@darkrain42.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "brian.pardy@gmail.com" <brian.pardy@gmail.com>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
In-Reply-To: <779ef3ac542e7e39027dee19d669ad2f81b05bcc.camel@uniklinik-freiburg.de>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
 <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius>
 <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
 <83d00d50bc628a85db71adb440d8afb5@matoro.tk>
 <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
 <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com>
 <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
 <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk>
 <457a5483c3c4ca5bb6c7ec6f4231074c.pc@manguebit.com>
 <779ef3ac542e7e39027dee19d669ad2f81b05bcc.camel@uniklinik-freiburg.de>
Date:   Mon, 23 Oct 2023 11:07:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de> writes:

> I can confirm that the patches apply cleanly on 6.5.8 and help a lot
> with the issue here (vers=3.1.1, gentoo client, MS AD server with DFS).

Thanks for testing it.

Steve, I would suggest below commits for v6.5.y

	238b351d0935 ("smb3: allow controlling length of time directory entries are cached with dir leases")
	6a50d71d0fff ("smb3: allow controlling maximum number of cached directories")
	2da338ff752a ("smb3: do not start laundromat thread when dir leases  disabled")
	e95f3f744650 ("smb: client: make laundromat a delayed worker")
	81ba10959970 ("smb: client: prevent new fids from being removed by laundromat")

If OK, please ask stable team to pick those up.
