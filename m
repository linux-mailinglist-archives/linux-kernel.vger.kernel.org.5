Return-Path: <linux-kernel+bounces-119763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35788CCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825051C664ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347E13CC4F;
	Tue, 26 Mar 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jijyd92X"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C743366;
	Tue, 26 Mar 2024 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480183; cv=none; b=ns8bb0Bza+dB1cSxYSS+oNtWChdvf4ZeKiNBnvDtUM8BfhxC4bAmiiq/H6jODwyJ/8wu8c8/zDgRB/UGoc1DYE0GbzDYmAm+WdIaJ6ndU7egukuw8+sttqq1JyywC5bcfqtDs9Gr84ipAFV2p1GU8g4m86p1wPhTiAXOcGZJgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480183; c=relaxed/simple;
	bh=FdJC7YspfBOLHkhVsu57qLrSG0id2LBh2qeggMHfgnc=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:
	 In-Reply-To:Content-Type; b=hq3cl35xmJNZzuPE/7JyYP2CNWvgbjhYcDMcHCcmiGAIv1NFPEFQsKsIZyrwla/HCBd8mIaYmk9Imsier/qqEUsAh8LMzbIzUAACcRQWsk4v387w97KHlnAxOmg3nb2EF1nb06P5ZsaHqOnXE6kzIbUBFVwBIgg/N+fVeiMhVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jijyd92X; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1711480172;
	bh=FdJC7YspfBOLHkhVsu57qLrSG0id2LBh2qeggMHfgnc=;
	h=Date:Subject:References:From:To:In-Reply-To:From;
	b=jijyd92XzfuMeh3rFQ5xWbHtO4bWMEYafM4dcuJtgfd6Tyzm1eCBvN/1VSgSdjaL6
	 t/wwKX2u+AKHsuY/uPXSev4p2Y54wUrxmZMexlqDG2X4762kDIIgpp03FMT8jVCs1z
	 y9fdvhrBPfBOen3nXOIYm8AF4tAORZG/E+wMJdyCyJBFjhEw+0oGIr6eByRNYuRRiQ
	 oYKgRoHhKcFuLT6wV462ZiEsPeI5vnvR4rPIZsfXyap8dSnEYyBU5N2kR2AuM7n5yX
	 BDjfiXtlf+7Df8cng6vqXs/fNXm606DTWIme1N36df3kWWxAd0uSAMBYX5IZI1Pmx9
	 PYS9VVize5upA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V3zrD4yX6zmyL;
	Tue, 26 Mar 2024 15:09:32 -0400 (EDT)
Message-ID: <bfc08896-dbc2-4b20-9aa2-4b173300a5fc@efficios.com>
Date: Tue, 26 Mar 2024 15:09:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [lttng-dev] [CTF2-SPEC-2.0] Announcing CTF 2, the next
 generation of the Common Trace Format
Content-Language: en-US
References: <YT3PR01MB9723DF471DF04203FC8FF2DFD3352@YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lwn@lwn.net, linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <YT3PR01MB9723DF471DF04203FC8FF2DFD3352@YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM>
X-Forwarded-Message-Id: <YT3PR01MB9723DF471DF04203FC8FF2DFD3352@YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

After 8 years of proposals and RC iterations, here is the final version
of the Common Trace Format specification version 2.

Feedback is welcome!

Mathieu

-------- Forwarded Message --------
Subject: [lttng-dev] [CTF2-SPEC-2.0] Announcing CTF 2, the next 
generation of the Common Trace Format
Date: Tue, 26 Mar 2024 19:00:37 +0000
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
To: diamon-discuss@lists.linuxfoundation.org 
<diamon-discuss@lists.linuxfoundation.org>
CC: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>, 
tracecompass-dev@eclipse.org <tracecompass-dev@eclipse.org>

To all tracing enthusiasts,

The Diagnostic and Monitoring Workgroup (DiaMon) is thrilled to announce
the launch of version 2 of the Common Trace Format (CTF), a binary trace
format designed to be fast to write without compromising great
flexibility.

The first version of CTF [1] has been widely used and tested in the
industry for almost fifteen years now, by different producers and
consumers.

CTF 2 is a major revision of CTF 1, bringing many improvements, such as:

‣ Using JSON text sequences [2] for the metadata stream.

‣ Simplifying the metadata stream.

‣ Adding new field classes (bit array, bit map, boolean, LEB128, BLOB,
   and optional) and improving existing ones.

‣ Supporting UTF-16 and UTF-32 string fields.

‣ Using roles instead of reserved structure member names to identify
   meaningful fields.

‣ Adding the attribute and extension features to extend and customize
   the format.

SPECIFICATION LINKS
━━━━━━━━━━━━━━━━━━━
The initial revision of CTF2-SPEC-2.0 is available here:

     <https://diamon.org/ctf/CTF2-SPEC-2.0.html>

Its AsciiDoc source is <https://diamon.org/ctf/CTF2-SPEC-2.0.adoc>.

The latest revision of CTF 2 is always <https://diamon.org/ctf/>.

The latest revision of CTF 1 is <https://diamon.org/ctf/v1.8.3/>.

FROM LEGACY TO FUTURE
━━━━━━━━━━━━━━━━━━━━━
The initial version of CTF [1] has been in widespread use and undergone
rigorous testing across various sectors by a range of users for close to
fifteen years.

Today, CTF 2 comes to existence to address significant limitations of
CTF 1 that make it challenging to implement a consumer and nearly
impossible to extend.

Developed over the course of eight years, CTF 2 is the culmination of
two initial proposals and nine release candidates, each one adding what
we now consider precious features that have incrementally shaped it into
the robust and versatile tracing format it is today.

We're confident that CTF 2 meets our important original design goals,
namely:

‣ CTF 2 data streams must be backward compatible with CTF 1 [1] data
   streams.

   CTF 2 only specifies metadata stream changes.

‣ The CTF 2 data streams must be highly efficient for a tracer to
   produce.

   The addition of features such as the configurable bit order of a
   fixed-length bit array field, variable-length integer fields, UTF-16
   and UTF-32 string field encodings, and BLOB fields makes this truer
   than ever.

‣ A CTF 2 metadata stream must be extensible by users of the
   specification.

   The namespaced attribute and extension mechanisms of CTF 2 metadata
   streams enable limitless extensibility.

‣ A CTF 2 trace should be easy to consume.

   A CTF 2 metadata stream is a JSON text sequence [2], removing all the
   complexity of parsing the custom DSL brought by CTF 1.

FEATURE HIGHLIGHTS
━━━━━━━━━━━━━━━━━━
CTF 2 brings many improvements over CTF 1, the most notable ones being:

JSON text sequence metadata stream:
     Whereas a CTF 1 [1] metadata stream is written in TSDL, a somewhat
     complex DSL inspired by the C language, a CTF 2 metadata stream is a
     JSON text sequence [2].

     A JSON text sequence simply is a sequence of JSON values, each one
     beginning with the "record separator (RS)" (U+001E) codepoint and
     ending with a "new line (NL)" (U+000A) codepoint.

     Using a JSON text sequence instead of a JSON array, for example,
     makes it easier to stream the objects of a CTF 2 metadata stream and
     allows the tracer to add metadata information while tracing occurs.

Attributes:
     Any trace producer may use attributes to add information to specific
     metadata stream objects, for example:

         {
           "type": "null-terminated-string",
           "encoding": "utf-16le",
           "attributes": {
             "meow-tracer": {
               "confidentiality-level": 4
             }
           }
         }

     A tracer may add namespaced attributes to trace class, data stream
     class, clock class, event record class, and field class objects.

     A general trace consumer may safely ignore attributes: you don't
     need them to decode a data stream.

Extensions:
     The purpose of an extension is to add core features to CTF 2 or to
     modify existing core features. In other words, an extension may
     alter the format itself. For example:

         {
           "type": "preamble",
           "version": 2,
           "extensions": {
             "meow-tracer": {
               "variable-clock-frequency": true
             }
           }
         }

     While a general trace consumer may safely ignore attributes, it must
     not ignore extensions.

Field roles:
     The name of a structure field member is now decoupled from any
     special meaning of said field.

     For example, you may name a packet header integer field `myosotis`
     and make it contain the current data stream ID:

         {
           "name": "myosotis",
           "field-class": {
             "type": "fixed-length-unsigned-integer",
             "byte-order: "little-endian",
             "length": 16,
             "roles": ["data-stream-id"]
           }
         }

New field classes:
     CTF 2 brings new field classes to fill some important gaps of CTF 1:

     Fixed-length bit array field:
         A compact sequence of bits without integral semantics.

         Any fixed-length scalar field conceptually is a fixed-length bit
         array field.

     Fixed-length bit map field:
         A fixed-length bit array field with flags associating bit index
         ranges to names.

     Fixed-length boolean field:
         A fixed-length bit array field of which the decoded value is
         either true or false.

     Variable-length integer field:
         An integral value encoded with the LEB128 [3] format.

     BLOB field:
         A compact, byte-aligned sequence of bytes with an associated
         media type:

             {
               "type": "static-length-blob",
               "length": 511267,
               "media-type": "image/tiff"
             }

         The length (number of bytes) of a BLOB field may be static or
         dynamic (provided by an anterior integer field).

     Optional field:
         A field which is either another field or nothing (zero bits):

             {
               "type": "optional",
               "selector-field-location": {
                 "path": ["config", "has-debug-info"]
               },
               "selector-field-ranges": [[1, 255]],
               "field-class": {
                 "type": "null-terminated-string"
               }
             }

         This is similar to what you could achieve with a variant field
         having an empty option in CTF 1.

All UTF string field encodings:
     A null-terminated, static-length, or dynamic-length string field may
     have the UTF-8, UTF-16BE, UTF-16LE, UTF-32BE, or UTF-32LE encoding:

         {
           "type": "static-length-string",
           "length": 32,
           "encoding": "utf32-be"
         }

JOIN THE MOVEMENT
━━━━━━━━━━━━━━━━━
We invite you to explore the CTF 2 specification and see firsthand the
impact it can have on your tracing projects.

Even though the CTF 2 specification is now published, your feedback
remains incredibly important to us so that we can be confident that the
document is flawless and as easy to understand as possible.

As far as DiaMon projects are concerned, what we know today about CTF 2
adoption is:

Babeltrace 2 [4]:
     Planned in the next minor release, Babeltrace 2.1.

LTTng [5]:
     Planned in LTTng 2.15.

Trace Compass [6]:
     Partial support currently; awaiting more CTF 2 trace samples to
     complete the development.

If you're considering adopting CTF 2 for your own project, please share
the news with us!

REFERENCES
━━━━━━━━━━
[1]: https://diamon.org/ctf/v1.8.3/
[2]: https://datatracker.ietf.org/doc/html/rfc7464
[3]: https://en.wikipedia.org/wiki/LEB128
[4]: https://babeltrace.org/
[5]: https://lttng.org/
[6]: https://eclipse.dev/tracecompass/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

