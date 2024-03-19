Return-Path: <linux-kernel+bounces-108238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31D88083B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73221F22856
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB595FBA2;
	Tue, 19 Mar 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leTn0/J+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2191E532;
	Tue, 19 Mar 2024 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891467; cv=none; b=Zmbs7ve21lXzUYrujtU62afh79LmsMpwjFJO3cgA35d4q/4brRz10DcsWKrjWsFWC93jyKE0AxV7/Uu6F2WNoGryD6v5kQe6Fb7PkJtpKSveoyAhdUhCaOKfDJAdCuZs+bskKU0LEonEZDc/DDtYdpouda45OImAFBmYXvhZ8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891467; c=relaxed/simple;
	bh=TA+MAvG6JzImlBiWlPnS4xkF7qajQFEsGeJD6fZf2As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGfMC1xuQ0wf1Cu8SkN4kW+hDxxgLg6y6VBs4xCwd0NM/0ND2tvxQGnEpSzny0Vjugfm9/Eiq06e7QHJb73mmooxfOQb6B+r0ketcdybclEGDDFYNTNnHrNsfW//9rBqlX/84rjG82uHp/NtC9OL1sTe/w1EnQr3m8Aasrp12s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leTn0/J+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51588f70d2dso202168e87.3;
        Tue, 19 Mar 2024 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710891463; x=1711496263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqJR4Bfl5/9Mw0uEi+g9JF38Q7VWzrrFkiKr7uV0fiM=;
        b=leTn0/J+/fEAYXX+fdVOzSHkx1bJSQYbyDnGd3/GVwdf0He/pdsLEyhblwauYVzXCx
         7req3tLxDzGe+zJk1Ubj7bEw3SfwNELiEx0yNX1v0LQbvenRsNwa4p7qdK4rYY8V+kgN
         rqf90Ydp7KYrFo2wkKHaepTCim4ET6rn/5mqH6zdNfDjmbBLTOPdPN2AVsEu/4W1AbTW
         x8K4LU462ew5xSjV6EEOhJL3WKhnojX/WKufwfachx22OlYoJzb7klPJgQpBmgRGbcz1
         Bv4n9wVwv/uUlEVwy4vKmDbcbOIA1i7sqqut3LFJ1/WHJw5tc4sxKYenlFzzc1JWCqLd
         DZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710891463; x=1711496263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqJR4Bfl5/9Mw0uEi+g9JF38Q7VWzrrFkiKr7uV0fiM=;
        b=MBZ07eEjVSv4E3P7O5XCDDRAPaMuufmApO2q65Yz9PximwgLrHUiO4E4aMq8WqCclM
         mDuszb4EVk2IlWigK1uUFLUDu66pxQdwMQz58H+dbdQS/B456nU1g0O4A5jcHIgMHlLb
         lJkoHjL3UPUPC85QGIVAx1m0X5kR4L5hecC9fXbb4fMijJceGcGu+UQZU3LXaTdIBfLK
         2iuevuHTxNyyJqx5Z+qKnD0td6oDsl286CYN5oSOvGgMDxW1CHLckAj72MTkyKyIvoSw
         bfGXGeETwPMJvF3AJC7WbDsJHscf0J0UUvObCDgyhyvWT4afIXuwrRoAf2ioBVpL1GlU
         oq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP5KP1nqD7JWm6nOn3gwQfTGitsUowAnIRBWG6nVEAwphzwDANQtR4YIb2X/cjEyckU/UjV7X1z5d2IKW5pyC7MwxE26f130gAJJELvvjt8SfpKlmL9GaqC9kbdM/WqCbHshUmnZx6ww==
X-Gm-Message-State: AOJu0YzEi8m4KJHF/PFVXHPb6VA1ITXlj+4Ws2ibSDcmtq9+aaAuXju+
	FchQcBYeyUOJ2paGYmdRVFJdaZ39NMgzqrF4tgQpgeeL8Ln4aAcb9c/4S2dJWoLnu3qy7avBc5j
	csEjGk798uc5zC266vocM1KtIHRs=
X-Google-Smtp-Source: AGHT+IGNXqoOg5hm8s4j6pbxepRWmB711QfgLrlsH051wKqjU0FoQteoWI2oNIOqhhBLVBVJUFauYU0Ppeb81Ee8LQc=
X-Received: by 2002:ac2:5b03:0:b0:513:bd72:a677 with SMTP id
 v3-20020ac25b03000000b00513bd72a677mr11238403lfn.19.1710891463156; Tue, 19
 Mar 2024 16:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320095957.324ec03b@canb.auug.org.au>
In-Reply-To: <20240320095957.324ec03b@canb.auug.org.au>
From: Steve French <smfrench@gmail.com>
Date: Tue, 19 Mar 2024 18:37:31 -0500
Message-ID: <CAH2r5mtpdFrGX90O5LAAKLKVJVT62LzqQNXby05MofhbUE5GVg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the cifs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Typo fixed - updated the patch in cifs-2.6.git for-next

On Tue, Mar 19, 2024 at 6:00=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> In file included from fs/smb/client/cifsglob.h:27,
>                  from fs/smb/client/cifsfs.c:36:
> fs/smb/client/../common/smb2pdu.h:291:9: error: unknown type name '_u8'
>   291 |         _u8 BlobData[];
>       |         ^~~
>
> Caused by commit
>
>   354c620afff2 ("smb311: additional compression flag defined in updated p=
rotocol spec")
>
> I have used the cifs tree from next-20240319 for today.
>
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve

