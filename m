Return-Path: <linux-kernel+bounces-139221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD258A0008
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080D91C223CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00616D33A;
	Wed, 10 Apr 2024 18:50:03 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE19168D0;
	Wed, 10 Apr 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775003; cv=none; b=Qaw0ZhoIUUoomycCwDAOwQZZ894FpaMbFJDr9r9FIji91GQPd3q7rzgCZXCoRrrymcjkuDxqsZt/1ZEC+mmNCVSuN33pKWjIqP1pNKXh8b1EEIkuH1RmiBy6ax2wvYAO865V5J3rXVPzGrxQfLPpx4r9cYhKiiz+5GiCldrRcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775003; c=relaxed/simple;
	bh=c4pPwbgwiqqdJxaSc43yKqcDmd033xH91pHU/NqzXr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avf73qRsILk6hPGF4sG1cFDu+Ty43QbXEZw3jIe8N38a04ENDClyadHNnd+3cLLYxWZGlJFzczVYt45dkE55sBokePAMSgB5Mh5gySR91I9neDCA1wLA/91poXDZFnsTsjz4L10448s6v71vp1pxML/vZsjaCFMRJJTIDopMvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso5034086a12.2;
        Wed, 10 Apr 2024 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775001; x=1713379801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKZAPT8QMTwCsUh3mwc8OzUalcUgWBk9/f9oj4LLoBc=;
        b=SBsGdmMpvJVOZC1EjH5L+HuPRNvO5YpMfgHshTzznS8HLCK3JUI9NsvlOGtpURr86O
         zbGcTXjlK8+YuTykpsKRng8cx9m1Bf04vjrnR/bsdjHAsVuS+wk/+2hM00lljg+jiDqH
         YlrGiQ4bc/knaCVwv9kJy4oYCPilQ7PwbY/oHw12y86+7T/09ZwKpO6yViwD3F6GI38S
         ff2zfVMEC9WEBzkfDexYdmZnchZcGDso2KXuIsO6PcqwlRG34EaG9q4MchlMcQpcQw9o
         SU7kFBBxZRGcvF8QwxTNO32EBMUvtjJDKauwaI2KgXjiRbtm91MPV3H0ijHr7vJJPPBS
         14WA==
X-Forwarded-Encrypted: i=1; AJvYcCVxrPJrQ4NgPbmWD2ptP5VPWi4vo762BWRkQcveRAWj0akf4Ku5WyAg2i931ncP/62FFcPWLMsmliEHKBc7arvQcqwnGCcWq1EMaObV
X-Gm-Message-State: AOJu0YwxNhl0Fz0wV3lnAerByeVOTQxHPgPfcTgfCVjaQ4DXnqTV6amv
	GXZpZyspuDJri5rXibQBU86UWLZ7IeqS0rTZ/pYZOd4w/lLxTiwtc5UGTQxt5I18tctJ+AD/QfU
	KgYWmPAIUPwAdy6Q4WXswI7cS3is=
X-Google-Smtp-Source: AGHT+IHa4VEmFp63/vuLtvka86iGZNtwk97w/yuVqlNAhytps/Mldf4I/slLJqbiudfqebs9oLqf49xrmAAm1R2wAfc=
X-Received: by 2002:a17:90a:b787:b0:2a0:7758:31ac with SMTP id
 m7-20020a17090ab78700b002a0775831acmr3529896pjr.25.1712775000800; Wed, 10 Apr
 2024 11:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410103458.813656-1-james.clark@arm.com>
In-Reply-To: <20240410103458.813656-1-james.clark@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Apr 2024 11:49:49 -0700
Message-ID: <CAM9d7ciyO0L61bSBZ73yGvBo6chhSEJK2WtVMV5BFT_0-tk7RQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf test: "object code reading" test fixes
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Spoorthy S <spoorts2@in.ibm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 10, 2024 at 3:35=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> A few fixes around the object code reading test. The first patch
> appears to be unrelated, but in this case the data symbol test is
> broken on Arm N1 by the second commit.
>
> Changes since V1:
>   * Put data symbol test fix first so that bisecting still works on N1
>   * Instead of skipping "test data symbol" on N1, add some noise into
>     the loop.
>   * Add a commit to replace the only usage of lscpu in the tests with
>     uname
>
> James Clark (4):
>   perf tests: Make "test data symbol" more robust on Neoverse N1
>   perf tests: Apply attributes to all events in object code reading test
>   perf map: Remove kernel map before updating start and end addresses
>   perf tests: Remove dependency on lscpu

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

