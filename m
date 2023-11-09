Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7157E6AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjKINKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKINKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:10:22 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931642D7E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:10:20 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso456968fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699535420; x=1700140220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JV11+ry9ypgOvB/ueYEXD6cjewziQve6/VjwutqezbA=;
        b=V1TjwSuSI184o/ZSmeSxQA3SzQmtg51QKYVm2alQQM71+PMrfYRFQqr+rQxk5OY2If
         T4/+rggHDLzIN8bOxGfsh/NKchCq9cJcG2mi4igUnioxOY4nOf9G4MSqVoKNeMNRdOSV
         FXgsYuq55LUpksS/BRpO8SC68thZt4Wu6F7b9CC5pWncOKuB3K+MmmuhB1zatDO0I4XP
         RPS2X1HC/r1ee7lO7UOMmNZ7OE8huGysLHJU9ygYUG0F15P8nhtvqOlmcQFtFtSdzJ5d
         GGuRxLtkeNQZJ1VxHT4pNgnjU2jmrV0YRtf64DMzpFvK/App3jlxXDQke7qW794aNlV7
         NZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535420; x=1700140220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV11+ry9ypgOvB/ueYEXD6cjewziQve6/VjwutqezbA=;
        b=NxwcQiIgRQ/x2vr0Fd8DORBfylXAlbWDsZsqrciqaYPOOJPtSPslJDlHzGYm3tc6Tj
         6OnSxbmq5cIsUGXIK/f+r2zo2oeoXXilj95Xp0HPPmGY/DEAjxCuQ3VzTLuIBqX31/6c
         q3A4CNrn2mKgpkzXhksuBxE+wgN5xvx+GTB/zkgmFYlXb9ZGb98TcRzUZ+H0M8mX6juD
         SjSzpIILNwa7N3wFmYQQzg2byI6/o8FY4ayUtjwWHinaFbNk7mUcdNRnZWMUFyfmxz6u
         G0hWU7/FbCqssqiVZ35SV1m5rCYWvP5+VLTkjw+qLwaqqhcm8AH+Z7r8dUPP+z37kt76
         rEkw==
X-Gm-Message-State: AOJu0YyrT/KnDgsoOC9mG1d0R2nkXzGt8zLQjL2trtH3aun1upxfvPS1
        0SNJqk5+qSIlUjVDMOTSfE8HLg==
X-Google-Smtp-Source: AGHT+IFqF1bMZkPqeN+dmQ9Z4ggdvclWepSRJQyOP72MVAgw9o7dLLTcY9Eng1IkZcmcvlxEi3YJMg==
X-Received: by 2002:a05:6870:1189:b0:1d5:a58d:1317 with SMTP id 9-20020a056870118900b001d5a58d1317mr4249746oau.10.1699535419810;
        Thu, 09 Nov 2023 05:10:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id dx45-20020a05687076ad00b001cd1a628c40sm692089oab.52.2023.11.09.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:10:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r14nZ-001nDU-MP;
        Thu, 09 Nov 2023 09:10:17 -0400
Date:   Thu, 9 Nov 2023 09:10:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Sword <gregsword0@gmail.com>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Message-ID: <20231109131017.GH4634@ziepe.ca>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
 <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
 <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev>
 <037148c3-c15b-4859-9b82-8349fcb54d0a@fujitsu.com>
 <CAEz=LcvVEBgW3f4q=ucuhLwNvD0xcunKLw+fLWSFbp14SUVNyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEz=LcvVEBgW3f4q=ucuhLwNvD0xcunKLw+fLWSFbp14SUVNyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:16:58PM +0800, Greg Sword wrote:
> > What I should do next?
> > Just state "RXE support PAGE_SIZE aligned MR" ? Then patches become
> > RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE aligned MR
> > RDMA/rxe: set RXE_PAGE_SIZE_CAP to starting from PAGE_SIZE
> 
> What do you take rdma maillist for? Your bugzilla, jira? or your dev
> program launch? Or your play ground?

We have a code of conduct on these mailing lists, please follow it or
stop posting.

Jason
