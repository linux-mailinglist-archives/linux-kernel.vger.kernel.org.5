Return-Path: <linux-kernel+bounces-112369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7179C8878FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A161F22FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79173F9CE;
	Sat, 23 Mar 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGKVbecM"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E21B95C;
	Sat, 23 Mar 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203465; cv=none; b=SeCA/84dgZ0vmLhXStOguj2WoIdzKcJq3haPxU4UFj8XrcZ7b7FHx/LpJ614+EVEE/EDLHAwq55kcDHVQ1N7f8fslMjv+WU22PyX+mXCoY73G5uEWI4NhXAh5YhWw8eqmZfJwHc2CLj6Co3/EaINQeq23/ABut1c4uyLTqAVpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203465; c=relaxed/simple;
	bh=BD9yYA9+NBOKWytxYhvu401uYJ4KnvGy7wWuykYTsv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgc71BpXsuWKVFycaQf04Yvl6GQO6a6qUtFg9dw9CVz8g6yDV0plzpnDOWfio8ka17jRdvkvfqJtNEy1OfqKLQhgyDREu+NjPKE5tMcuCyUPSDjL6NxDNkBLfQeZc6mwCyoLQWZd3FFRIg5qFJkkNORhfedt3b3aCljXpD6Cb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGKVbecM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3686717e82aso11256765ab.2;
        Sat, 23 Mar 2024 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203463; x=1711808263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Du2UCi/Za+fAfUfXxuWN/JpNBxR09hI/ccpSO9Qj/c=;
        b=KGKVbecMuVz/Jz1qv1r4VGjp817EduSRvUUmHvAiwhHSQ6E7TsdmlegobBej5SCPxo
         BrV7SaZujD56dDdtj/ddlgdy3dtXrLnMjrA2Yfy6K6GW0tpWYTU5XeoIFvr3zbcC1olK
         ucxaEGewfzbo6iyz4Zoq3XrYeVv3j2J6uVN4WlI96cIwfJbRVwaDGwWyu0bsgKE+zk+8
         tQk6qPLfXjpNESfrrzvqB72Al8zAgemIZbd7Z9tsvY7fmht61lh+g+cC6TXmfCgAFDd2
         iknBLBwGd+qoFCRjiZb/7KYDJg7Ku/BLwaXUJXDQ7Tq/1lxi3dE6hIGyLuWxyfgo1nM+
         Iycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203463; x=1711808263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Du2UCi/Za+fAfUfXxuWN/JpNBxR09hI/ccpSO9Qj/c=;
        b=ilnBdj1kPT10TjENOPnk9TvedBrz+H6RbP78iJRNPovBNJLS9V02w55zV+aYC4uiOY
         zQtTypigzTpwfaSLIyH6lwI1Uf+8WzjZFqyOsJBwosDdXgvvVFdwdZhYRYWRJx+Z4BMu
         y7eW2BFIYD5Xeq/m1vrIEeaZQ7HD3gSeIml80JATabg42mQuO1DRZj7RI1zd/absFBDe
         eIdo1F7jmtPiMpgGZASEbvpE1rdjA9tDPF+JoNzyJrKEcSnw2w/j+IasA7EAHLXEW2aT
         ocs+3wzJDiynRPpwRg53VKTXCcRMfG5GGAJSF8s2cq66Qbane4HV/umyuLuZwS5aa7tc
         xRcg==
X-Forwarded-Encrypted: i=1; AJvYcCWu5gf87Jnd4v7y+ITqorUlNdLHj/c5oB2uzjZ9lkKc6thwk9f6yJ4qsk1TT2qDbuUVgp74JVMxBV5OJ7Q8yIb2Hb1IW1cJXJRxJ5OI2QSEYULqMwsZQR8mA6YkCjXma3jZF6JcOjJWzg15vlnWCzM3k+Bzz8WKaGB2XjvoDhpnlBoRFjIH
X-Gm-Message-State: AOJu0Yz1iD/VerTWVFHQiXu3LTIF4Is4bLzYQ9/pDM2JJdsk+nOkHhBw
	Ijnu/pDPKYtniKdgyYqDRNxHGNmhD1YOMbPMLNEdClIQ9qnyLgnD
X-Google-Smtp-Source: AGHT+IHSImgq5ZoHSc8ygl85DESurCHPEm/wpSMX4HtohmWmvpXpFOETDeT6qYeBe0Sv2AKB2WDdYA==
X-Received: by 2002:a92:d14a:0:b0:365:b4c7:5e9d with SMTP id t10-20020a92d14a000000b00365b4c75e9dmr2404375ilg.27.1711203462886;
        Sat, 23 Mar 2024 07:17:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l63-20020a632542000000b005f034b4d123sm3177412pgl.24.2024.03.23.07.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:17:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:17:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Message-ID: <c1affb1b-4c36-4428-8c9f-a585206f87fa@roeck-us.net>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
 <20240322-hwmon_dtschema-v3-3-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v3-3-6697de2a8228@gmail.com>

On Fri, Mar 22, 2024 at 08:24:37PM +0100, Javier Carrasco wrote:
> This binding was converted to dtschema a year ago.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

