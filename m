Return-Path: <linux-kernel+bounces-67094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F84856634
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772511C234B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06019132476;
	Thu, 15 Feb 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1JIFruB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B512FB27;
	Thu, 15 Feb 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008327; cv=none; b=OcCCcLaLWXKfYUZcMrLaMRjOakpzy1+KM+kV4KRJoHZIXgJ7pqfunixDjuRGD7t8nJak7hSW+W8f7Iw/XSBBj3A2uwmqPZO1nkqLuyn8qcz1XNQyKdcQOvnEEyBoWgtrtl5gkUmhcIDgR3leRPlllKmwFUeQsaU+nU2J0YZ2zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008327; c=relaxed/simple;
	bh=LPUOFu7WLKyoXiPFaOq1qgAw3EKIJNdPwBe3sTwrqoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gySWZW6m8Lsjf9m8dPOzl/AzwJ1c3s+ItuPHiYCF+OhR4W//IwnD1kFSyYK6nOTr+LdIp9GaKiB0dRWk6Vwy+k2gRtH8jIiY/a4T44JaZiyM8kKXCAuypjsIta2RRrezlzczeqGju3pGbxbpPZa1V31CLR7gvOOwq40yYL8WPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1JIFruB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3832ef7726so121692366b.0;
        Thu, 15 Feb 2024 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708008324; x=1708613124; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPUOFu7WLKyoXiPFaOq1qgAw3EKIJNdPwBe3sTwrqoA=;
        b=E1JIFruB3xxtsHyJWRocDwV1pBJ02WRGlSG1w98hBXTQO2u0JcJsj/07u/bOIX457g
         jYhBAQw3uS5V6/LW9cHu/nwCBxIzA5lzWfto1K7By+WHmYJZwAv7zR72UZjD7zsP2kkr
         B8dDKoeJWFE80/LuRvGiHXMeSI1li2SYJMbLqRfgTWVT6kJAgq3z4O4YNIHSHHadXTXd
         QSv+aMV1BGq/0W1Yk4pLGJO0izWbyt3XGLGanH82BT0dkUmKL4y+taz9/Rb8Pz2fi2Oy
         cFgwY+QJVKpXSubqJ8aXQ6JbCV3YvomYDlrv0NSMyG4ad8jcqDKH8fq0XwO1w/yOP0IW
         JS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008324; x=1708613124;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPUOFu7WLKyoXiPFaOq1qgAw3EKIJNdPwBe3sTwrqoA=;
        b=Nsk40robfysSUn/umGnl95soAHn1E9LTO12pdaa19FM9RK2cykWxL3AG3Buiv5ONff
         o3AOplyKAXU7zYtfS/zU5nx/Qa9RSeLxlWsT1dZArcR0H7+s61RJDIQRNho3BgFX+3Hj
         KruO+zDHtgX2p8hGlxCP97cqHS0oPW1cBrOFvS8T0wE8lbOnlYECXIfAF8t68IjX3SPk
         hTGIRURXNTokCWyCI0ZXPv0R1W/wKgI5eXDVp8TU3EhtTqi3QuACtRet2RNczno19Mxi
         RhScWGxgEp4JHtVU+VhXUagR0ratrEYdNTNlUlG0CUBTwEr8KQnj5UE1pn5wC4rkzQK/
         bLNw==
X-Forwarded-Encrypted: i=1; AJvYcCUlvkfSfobwJardtTgXZ0Up8D6N29p/rChMsm2tQj7H8ibnra1o3a6gwCiybS+Qifacz1mKhQu3/BrJo441ctSdatDDixInhGwIU5bB+Fp9yrzs/g==
X-Gm-Message-State: AOJu0YzcLrqlhcSLm7CJP1gR2GTX5GeNztKGr/Uh3OjcV6HxUYA48zSW
	HLCAcymA9BSVND28pE2eyxsFfdm42KE76wbBvCOuWS4/pkciXtQjgkVVXCfATTIfdrq6WVoZhbC
	N4WFRBQotdBXLfdLSua731grlB4F0seBm
X-Google-Smtp-Source: AGHT+IGI9II9C7WmI9yf8UBMCiZEHWwI6uGZnv5DIMvOHaxOH0hm6A72Sctu0mTFP4TF9lipwu8LuQWnwtPgNF670AU=
X-Received: by 2002:a17:906:b847:b0:a3d:6f46:ac3a with SMTP id
 ga7-20020a170906b84700b00a3d6f46ac3amr1439053ejb.11.1708008323366; Thu, 15
 Feb 2024 06:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jon Maser <jonmaser8@gmail.com>
Date: Thu, 15 Feb 2024 06:45:12 -0800
Message-ID: <CAF=mWJOF21M+4ZRDAdgNNszshrsGRXBKx7QcDZjpb8VnSE7bGw@mail.gmail.com>
Subject: hey I have an idea for a frontend for kernel make/configures
To: LKML <linux-kernel@vger.kernel.org>, linux-c-programming@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

im new to kernel dev so sorry if im a newb!

im not sure if im supposed to do this to the config file or make file

first of all you can, by an argument switch, print stdout from xmake
and output std in for some kind of gui program i think, like xmake
--gui || xmakegui, and it can be piped to a gui stdin, i think.

you can do, i'll call it, xmake

xmake newproject --source=$dir --config=$path_to_config --output=/usr/src/$var

that will tell xmake to read the source dir, read the config file, and
output new projects through output.

configs can be configured in complex or simple ways, stuff like values
in the arch configs, maybe you can use machine learning to scan stuff
and make a good config, or maybe do some shell action, maybe do some
fancy sed/awk dancing, and sed/awk could be useful for gpt3

you can also do xmake newproject kernel and generate a new kernel
config, or xmake git://github.com --profile=`wget $url/7.2-ml.cfg`
(outputs to /usr/src/7.2-ml)

id write it but im a little strapped for time, have class

but heres the stuff id like to put in xmake to start, just the
commands, your free to implement yourself

xmake newproject calculator --config=$mathopt
(no output outputs the source files to a default directory)

and theres deleteproject, profileproject (builds a heuristic profile
of the source for optimized builds), ai-build (which takes string
queries i guess, might be slow) and machine learning for when that
gets to linux. i can imagine stuff like intelligent stacks and queues
with ai, along with liminal speed

and a backup option

if you want to implement this for your workstation or see if you can
include it in the linux kernel it'd be great, its just as easy as
building a skeleton project and possibly some parsing, id do python
but its just as fun in c or cpp

