Return-Path: <linux-kernel+bounces-128813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7F895FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CAB1F2409C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3433B193;
	Tue,  2 Apr 2024 23:03:47 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539E2260B;
	Tue,  2 Apr 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099027; cv=none; b=NdJbh4bhYTUWm5MqSUPlRQI8tA3rCp6BapuyulItaRtsQhpfdsgY5m4/fZeWH7V46nw9LnUXOfGdXUvW0R/fpP8vtQAxjR1ocOogmeEhNeUNAPs0L0Qu25wSjs3ENKZ1er8gjFd5tVsrauUEw4eSRFrlCB/oS6fduahczgZmank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099027; c=relaxed/simple;
	bh=ScF6QNSnuOKd9KNJpYsFm03BlNSwOxnA/QZp3srCbNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhcQOd9aKXlyahk8fM2/6PkFXO38RDdRhjlb5AT9lktcNywQosq35A65CZlsGGNzKRRrC60Gr4Qd7tv5J2fN25+wNRy3SeIlDjQjBD1smpr6/aTj8cHfREX1J6JaYJTI1XJBO/C0c3dc32WRWKl2BGIJ4lPu8R5PQEJ8vhRiknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so3412645a12.3;
        Tue, 02 Apr 2024 16:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712099025; x=1712703825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzCXitGPhuYyMfQTaMVMsMslYOPk+D4W9QEmIyDGsKY=;
        b=rUqSKQZ82jNZsKTk4fJTo3FaDs0pAVwkELurCTPqaGvPP4MhjjwpCyEl6A5w/+unRA
         mmRU055Ng3XnQ283vPUrGDjraTr1TmYgC1U+62WifYbH1CfBj4P7QlMcpXyX3qzqQjT8
         YboI6G4hEMXy9sFO1GHXKiE6OYrFCZI7EAl498keeeHKK4jMz51Kvs+XON0ZZov/pZaa
         jqty5oEYk1ydfky97ed7eI/de5XAeEnBMwTh6Ew8SgAenUJpLCamajAPEs2x+ZC+qwXn
         hZzT50ngEoZ5NlXC+oFPKf0jB7R7pODstSGVRFeHDY5sd2kAZR4DJ38l1qe64XzIeoOm
         BiCA==
X-Forwarded-Encrypted: i=1; AJvYcCU31/0iRnq7MORXYRBIeR+sKCDV3qhSCG3bfU3IGRlwG4iM05tfHmeEWsplm5tkUrdDPP/ESdiSebNABX+orQ6VGDh9ryvmA/JgoTKbRYyGixIpM3sd4DMkRmM+1xD0oNwvd5Ap3fNJVhySZbKmsQ==
X-Gm-Message-State: AOJu0Yxqx3YwKu2NmUU3sYU21YlPSZfTh5G1er84xER7aUrLuaZLGXMO
	FQTkhsS8PwGmyT8uRsxutx8wjijok0TES9ZT+H2UsXt0+SxOkMGDtTHGnwNCJmmj9O7FduZ42OO
	Md6GNFoEBoC8YVDoCh+70reaFlAM=
X-Google-Smtp-Source: AGHT+IGszTCneZu4ykuvLxJsvsUgt2mSghjdJCooBB86zYzoye45jsKqEZ1uuYbwuK8XVNcTAPmAZ5SB1MvmjwiiMz4=
X-Received: by 2002:a17:90b:4b10:b0:2a2:672f:ef6d with SMTP id
 lx16-20020a17090b4b1000b002a2672fef6dmr921013pjb.49.1712099024988; Tue, 02
 Apr 2024 16:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329215812.537846-1-namhyung@kernel.org> <20240329215812.537846-4-namhyung@kernel.org>
 <ZgyBwTWv8OZlbl9m@x1> <ZgyCkETBtsTX3tA8@x1>
In-Reply-To: <ZgyCkETBtsTX3tA8@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 2 Apr 2024 16:03:33 -0700
Message-ID: <CAM9d7cgyeaeTPyw5fZjX2OsVrGqv-VrqpU_RPgUu8yWN+qTDsg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] perf annotate: Split out util/disasm.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:11=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Apr 02, 2024 at 07:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 29, 2024 at 02:58:10PM -0700, Namhyung Kim wrote:
> > > The util/annotate.c code has both disassembly and sample annotation
> > > related codes.  Factor out the disasm part so that it can be handled
> > > more easily.
> > >
> > > No functional changes intended.
> > >
> >
> > Unsure if here, will check and fix later, detected with:
> >
> >   make -C tools/perf build-test'
>
> did it, added the missing env.h header to disasm.c

Thanks a lot!
Namhyung

