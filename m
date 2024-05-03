Return-Path: <linux-kernel+bounces-167385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD198BA8C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A806B1F22AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF814A084;
	Fri,  3 May 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flDpKJzy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46317C6D;
	Fri,  3 May 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725020; cv=none; b=Su0ZSkCbUYtcQzUwyGm6w3oS82O0vY/0K8v4cqiNwoQGp9NZjX6AZg4lA2qdF6H1Cj0GReYGzlm/f1wLhumV0KyrAJu063bkYJ4TWC5LTM8tZv7qHjnYrDzPXimNeagX0GSb80cKOPxzdnZNlSFj8YKm8KqnKHu2fDV75+4/1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725020; c=relaxed/simple;
	bh=2c1HxpMiDtlMZuBg2aZ3i/0g03ebVG0A/11pi6dMJME=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q6Kgd/YlwPuX0vMXdjmoBnyK4w7XhC9Aarp5bZR1L3YNHahqFqJEF7uKUU7cIYGq1IR0B/v4meEvX26tzxWLFfts4EofXbPtvuE8mpEB/1I2QjOPlBLR1Acri8f07FOlQQ5Sce35KfsLM+i8E2sTKi+o61gkGuiPkX6BxB70sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flDpKJzy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714725019; x=1746261019;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2c1HxpMiDtlMZuBg2aZ3i/0g03ebVG0A/11pi6dMJME=;
  b=flDpKJzymbZx0jJ2mMOy87onZFrBsAe8JAtVVR4yrO3UajHI6C1yCn6E
   Q1o/hcJ9u9MKRoQGV6NTRr3DIosDkmDQ4VPzYK8ujY6uV1tasyqPQtlOA
   102mAiywGLQO2jxWeqKcLlGssdHcd5hMfQBGPZsNowYuFIEPioUmx0vkD
   +JIBJZYBymcXCtaGRgcEkKa2IpQPsUrKToZfwGQylKr5ybqLHd3RpHBLk
   q8dDtwu8FZ+ltWqBQcgzjFOOB7u9gWEN80QgsTaVY9BpfGiAaiF811GMK
   YQw/O5eqsdwX/SRLHi4Fdl8ODWC+5JJO3yHZc2Rgh2+XAZOX7euhTRZv4
   A==;
X-CSE-ConnectionGUID: ccv37Xl4TRilCFZ8FmAXCA==
X-CSE-MsgGUID: wpzeX9MAQtyl0YbfW3yVpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21678118"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21678118"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 01:30:18 -0700
X-CSE-ConnectionGUID: PeoEPU5JQUOfBlBJfPE2Vg==
X-CSE-MsgGUID: hPkPO75BTbKH2AVK3uiLrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27438350"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.56])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 01:30:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 3 May 2024 11:30:10 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/arch/x86/intel_sdsi: Add attestation support
In-Reply-To: <20240503025727.10254-2-david.e.box@linux.intel.com>
Message-ID: <92993e65-463a-584b-c818-45c409ad69fb@linux.intel.com>
References: <20240503025727.10254-1-david.e.box@linux.intel.com> <20240503025727.10254-2-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, David E. Box wrote:

> Add support on the intel_sdsi tool to perform SPDM GET_DIGESTS and
> GET_CERTIFICATE commands. Output is sent to stdout.
> 
> Example reading the certificate chain from socket 0:
> 
> intel_sdsi -d 1 -attest get_certificate | openssl x509 -inform DER -nout -text
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  tools/arch/x86/intel_sdsi/Makefile     |  27 +-
>  tools/arch/x86/intel_sdsi/intel_sdsi.c |  70 +++-
>  tools/arch/x86/intel_sdsi/spdm.c       | 466 +++++++++++++++++++++++++
>  tools/arch/x86/intel_sdsi/spdm.h       |  13 +
>  4 files changed, 565 insertions(+), 11 deletions(-)
>  create mode 100644 tools/arch/x86/intel_sdsi/spdm.c
>  create mode 100644 tools/arch/x86/intel_sdsi/spdm.h
> 
> diff --git a/tools/arch/x86/intel_sdsi/Makefile b/tools/arch/x86/intel_sdsi/Makefile
> index 5de2288cda79..6da6c4ee96d7 100644
> --- a/tools/arch/x86/intel_sdsi/Makefile
> +++ b/tools/arch/x86/intel_sdsi/Makefile
> @@ -1,21 +1,28 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Intel Software Defined Silicon provisioning tool
> -
> -intel_sdsi: intel_sdsi.c
> -
> -CFLAGS = -Wextra
> -
> +include ../../../scripts/Makefile.include
>  BINDIR ?= /usr/sbin
>  
> -override CFLAGS += -O2 -Wall
> +SRCS = intel_sdsi.c spdm.c
>  
> -%: %.c
> -	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
> +OBJS = $(SRCS:.c=.o)
> +
> +override CFLAGS += -O2 -Wall -Wextra -I../../../include -ggdb3
> +
> +intel_sdsi: intel_sdsi.h $(OBJS)
> +	$(CC) $(CFLAGS) $(OBJS) -o $@
> +
> +intel_sdsi.h: ../../../../include/uapi/linux/intel_sdsi.h
> +	ln -sf ../../../../include/uapi/linux/intel_sdsi.h $@
> +
> +%.o: %.c
> +	$(CC) $(CFLAGS) -c $< -o $@
>  
> -.PHONY : clean
>  clean :
> -	@rm -f intel_sdsi
> +	@rm -f intel_sdsi intel_sdsi.h $(OBJS)
>  
>  install : intel_sdsi
>  	install -d  $(DESTDIR)$(BINDIR)
>  	install -m 755 -p intel_sdsi $(DESTDIR)$(BINDIR)/intel_sdsi
> +
> +.PHONY : clean install

Why is Makefile rework in this patch. Should it like be in own patch?

> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 766a5d26f534..419f43e403b7 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -22,6 +22,9 @@
>  
>  #include <sys/types.h>
>  
> +#include "spdm.h"
> +#include "intel_sdsi.h"
> +
>  #ifndef __packed
>  #define __packed __attribute__((packed))
>  #endif
> @@ -179,6 +182,7 @@ struct sdsi_dev {
>  	struct state_certificate sc;
>  	char *dev_name;
>  	char *dev_path;
> +	int dev_no;
>  	uint32_t guid;
>  };
>  
> @@ -189,6 +193,12 @@ enum command {
>  	CMD_STATE_CERT,
>  	CMD_PROV_AKC,
>  	CMD_PROV_CAP,
> +	CMD_ATTESTATION,
> +};
> +
> +enum spdm_message {
> +	GET_DIGESTS,
> +	GET_CERTIFICATE,
>  };
>  
>  static void sdsi_list_devices(void)
> @@ -647,6 +657,41 @@ static int sdsi_provision_cap(struct sdsi_dev *s, char *bin_file)
>  	return sdsi_provision(s, bin_file, CMD_PROV_CAP);
>  }
>  
> +static int sdsi_attestation(struct sdsi_dev *s, enum spdm_message message)
> +{
> +	struct cert_chain c;
> +	uint8_t digest[TPM_ALG_SHA_384_SIZE];
> +	size_t size;
> +	int ret, i;
> +
> +	switch (message) {
> +	case GET_CERTIFICATE:
> +		ret = spdm_get_certificate(s->dev_no, &c);
> +		if (ret)
> +			return ret;
> +
> +		size = fwrite(c.chain, sizeof(uint8_t), c.len, stdout);
> +		if (size != c.len) {
> +			fprintf(stderr, "Unable to write complete certificate chain\n");
> +			ret = -1;
> +		}
> +
> +		free(c.chain);
> +		break;
> +	case GET_DIGESTS:
> +		ret = spdm_get_digests(s->dev_no, digest);
> +		if (ret)
> +			return ret;
> +
> +		for (i = 0; i < TPM_ALG_SHA_384_SIZE; i++)
> +			printf("%02x", digest[i]);
> +		printf("\n");
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int read_sysfs_data(const char *file, int *value)
>  {
>  	char buff[16];
> @@ -728,6 +773,7 @@ static struct sdsi_dev *sdsi_create_dev(char *dev_no)
>  	}
>  
>  	s->guid = guid;
> +	s->dev_no = atoi(dev_no);
>  
>  	return s;
>  }
> @@ -742,6 +788,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
>  static void usage(char *prog)
>  {
>  	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m | -C] [-a FILE] [-c FILE]\n", prog);
> +	printf("       [-attest MESSAGE]\n");

Long options use -- ?

>  }
>  
>  static void show_help(void)
> @@ -754,12 +801,15 @@ static void show_help(void)
>  	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate data");
>  	printf("  %-18s\t%s\n", "-C, --meter_current",  "show live unattested meter data");
>  	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
> -	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
> +	printf("  %-18s\t%s\n", "-c, --cap FILE",       "provision socket with CAP FILE");
> +	printf("  %-18s\t%s\n", "-attest MESSAGE",      "send attestion MESSAGE. MESSAGE");

-- ?

> +	printf("  %-18s\t%s\n", "",                     "values are:");
>  }
>  
>  int main(int argc, char *argv[])
>  {
>  	char bin_file[PATH_MAX], *dev_no = NULL;
> +	enum spdm_message message = GET_DIGESTS;
>  	bool device_selected = false;
>  	char *progname;
>  	enum command command = -1;
> @@ -769,6 +819,7 @@ int main(int argc, char *argv[])
>  
>  	static struct option long_options[] = {
>  		{"akc",			required_argument,	0, 'a'},
> +		{"attest",		required_argument,	0, 0},
>  		{"cap",			required_argument,	0, 'c'},
>  		{"devno",		required_argument,	0, 'd'},
>  		{"help",		no_argument,		0, 'h'},
> @@ -820,6 +871,20 @@ int main(int argc, char *argv[])
>  
>  			command = (opt == 'a') ? CMD_PROV_AKC : CMD_PROV_CAP;
>  			break;
> +		case 0:
> +			if (strcmp(long_options[option_index].name, "attest") == 0) {
> +				command = CMD_ATTESTATION;
> +
> +				if (strcmp(optarg, "get_digests") == 0)
> +					message = GET_DIGESTS;
> +				else if (strcmp(optarg, "get_certificate") == 0)
> +					message = GET_CERTIFICATE;
> +				else {
> +					fprintf(stderr, "Unrecognized attestation command\n");
> +					return -1;
> +				}
> +			}
> +			break;
>  		case 'h':
>  			usage(progname);
>  			show_help();
> @@ -854,6 +919,9 @@ int main(int argc, char *argv[])
>  		case CMD_PROV_CAP:
>  			ret = sdsi_provision_cap(s, bin_file);
>  			break;
> +		case CMD_ATTESTATION:
> +			ret = sdsi_attestation(s, message);
> +			break;
>  		default:
>  			fprintf(stderr, "No command specified\n");
>  			return -1;
> diff --git a/tools/arch/x86/intel_sdsi/spdm.c b/tools/arch/x86/intel_sdsi/spdm.c
> new file mode 100644
> index 000000000000..b5bf91215cbb
> --- /dev/null
> +++ b/tools/arch/x86/intel_sdsi/spdm.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * spdm: Lightweight Security Protocol and Data Model (SPDM) specification
> + * support code for performing attestation commands using the Intel On
> + * Demand driver ioctl interface. Intel On Demand currently supports
> + * SPDM version 1.0
> + *
> + * See the SPDM v1.0 specification at:
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf
> + *
> + * Copyright (C) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#include<linux/bits.h>
> +
> +#include<fcntl.h>
> +#include<stdio.h>
> +#include<stdlib.h>
> +#include<stdint.h>
> +#include<string.h>
> +#include<unistd.h>
> +#include<sys/ioctl.h>

Where's the whitespace?

> +
> +#include "spdm.h"
> +#include "intel_sdsi.h"
> +
> +// SPDM constants
> +#define SPDM_VERSION			0x10
> +#define SPDM_REQUEST			0x80
> +#define SPDM_ERROR			0x7f
> +
> +// SPDM request codes
> +#define SPDM_GET_VERSION		0x84
> +#define SPDM_GET_CAPABILITIES		0xE1
> +#define SPDM_NEGOTIATE_ALGORITHMS	0xE3
> +#define SPDM_GET_DIGESTS		0x81
> +#define SPDM_GET_CERTIFICATE		0x82
> +#define SPDM_CHALLENGE			0x83
> +#define SPDM_GET_MEASUREMENTS		0xE0
> +
> +#define SDSI_DEV_PATH			"/dev/isdsi"
> +
> +#define SPDM_RSVD			0
> +
> +#ifndef __packed
> +#define __packed __attribute__((packed))
> +#endif
> +
> +struct spdm_header {
> +	uint8_t version;
> +	uint8_t code;
> +	uint8_t param1;
> +	uint8_t param2;
> +} __packed;

Does this really need packed?

> +static int error_response(struct spdm_header *response)
> +{
> +	if (response->code != SPDM_ERROR)
> +		fprintf(stderr, "ERROR: Unrecognized SPDM response\n");
> +
> +	switch (response->param1) {
> +	case 0x00:
> +	case 0x02:
> +	case 0x06:
> +	case 0x08 ... 0x40:
> +	case 0x44 ... 0xfe:
> +		fprintf(stderr, "SPDM RSP ERROR: Reserved.\n");
> +		break;
> +	case 0x01:
> +		fprintf(stderr, "SPDM RSP ERROR: One or more request fields are invalid.\n");
> +		break;
> +	case 0x03:
> +		fprintf(stderr, "SPDM RSP ERROR: The Responder received the request message\n");
> +		fprintf(stderr, "and the Responder decided to ignore the request message\n");
> +		fprintf(stderr, "but the Responder may be able to process the request message\n");
> +		fprintf(stderr, "if the request message is sent again in the future.\n");
> +		break;
> +	case 0x04:
> +		fprintf(stderr, "SPDM RSP ERROR: The Responder received an unexpected request\n");
> +		fprintf(stderr, "message. For example, CHALLENGE before NEGOTIATE_ALGORITHMS.\n");
> +		break;
> +	case 0x05:
> +		fprintf(stderr, "SPDM RSP ERROR: Unspecified error occurred.\n");
> +		break;
> +	case 0x07:
> +		fprintf(stderr, "SPDM RSP ERROR: The RequestResponseCode in the request\n");
> +		fprintf(stderr, "message is unsupported.\n");
> +		break;
> +	case 0x41:
> +		fprintf(stderr, "SPDM RSP ERROR: Requested SPDM Major Version is not\n");
> +		fprintf(stderr, "supported.\n");
> +		break;
> +	case 0x42:
> +		fprintf(stderr, "SPDM RSP ERROR: See the RESPONSE_IF_READY request message.\n");
> +		break;
> +	case 0x43:
> +		fprintf(stderr, "SPDM RSP ERROR: Responder is requesting Requester to reissue\n");
> +		fprintf(stderr, "GET_VERSION to resynchronize.\n");
> +		break;
> +	case 0xFF:
> +		fprintf(stderr, "SPDM RSP ERROR: Vendor or Other Standards defined.\n");
> +		break;
> +	}
> +
> +	return -1;
> +}
> +
> +static int sdsi_process_ioctl(int ioctl_no, void *info, uint8_t dev_no)
> +{
> +	char pathname[14];
> +	int fd, ret;
> +
> +	ret = snprintf(pathname, 14, "%s%d", SDSI_DEV_PATH, dev_no);
> +	if (ret < 0)
> +		return ret;
> +
> +	fd = open(pathname, O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +
> +	ret = ioctl(fd, ioctl_no, info);
> +	if (ret)
> +		perror("Failed to process ioctl\n");
> +
> +	close(fd);
> +
> +	return ret;
> +}
> +
> +static int
> +sdsi_process_spdm(void *request, void *response, int req_size, uint32_t rsp_size,
> +		  int dev_no)
> +{
> +	struct sdsi_spdm_command *command;
> +	struct sdsi_spdm_message *message = request;
> +	uint8_t request_code;
> +	int ret;
> +
> +	command = malloc(sizeof(*command));
> +	if (!command) {
> +		perror("malloc\n");

perror() strings should not end into newline characted because the colon 
and error message is appended into the string argument.

> +		return -1;
> +	}
> +
> +	command->size = req_size;
> +	command->message = *message;
> +	request_code = command->message.request_response_code;
> +
> +	ret = sdsi_process_ioctl(SDSI_IF_SPDM_COMMAND, command, dev_no);
> +	if (ret)
> +		goto free_command;
> +
> +	if (command->size < sizeof(struct spdm_header)) {
> +		fprintf(stderr, "Bad SPDM message size\n");
> +		ret = -1;
> +		goto free_command;
> +	}
> +
> +	if (command->message.request_response_code != (request_code & ~SPDM_REQUEST)) {
> +		ret = error_response((struct spdm_header *)&command->message);
> +		goto free_command;
> +	}
> +
> +	if (response) {
> +		if (command->size > rsp_size) {
> +			fprintf(stderr, "SPDM response buffer too small\n");
> +			ret = -1;
> +			goto free_command;
> +		}
> +
> +		memcpy(response, &command->message, command->size);
> +	}
> +
> +free_command:
> +	free(command);
> +	return ret;
> +}
> +
> +struct version_number_entry {
> +	uint8_t alpha:4;
> +	uint8_t update_version_number:4;
> +	union {
> +		uint8_t version;
> +		struct {
> +			uint8_t minor:4;
> +			uint8_t major:4;
> +		};
> +	};
> +} __packed;
> +
> +struct get_version_response {
> +	struct spdm_header header;
> +	uint16_t reserved:8;
> +	uint16_t version_number_entry_count:8;
> +	struct version_number_entry entry[10];
> +} __packed;
> +
> +static int spdm_get_version(int dev_no)
> +{
> +	struct spdm_header request = {};
> +	struct get_version_response response = {};
> +	uint8_t version;
> +	int ret;
> +
> +	request.version = SPDM_VERSION;
> +	request.code = SPDM_GET_VERSION;
> +	request.param1 = SPDM_RSVD;
> +	request.param2 = SPDM_RSVD;
> +
> +	ret = sdsi_process_spdm(&request, &response, sizeof(request),
> +				sizeof(response), dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Failed GET_VERSION\n");
> +		return ret;
> +	}
> +
> +	if (!response.version_number_entry_count) {
> +		fprintf(stderr, "Bad GET_VERSION entry count\n");
> +		return -1;
> +	}
> +
> +	version = response.entry[0].version;
> +
> +	if (version != SPDM_VERSION) {
> +		fprintf(stderr, "Unsupported version 0x%x\n", SPDM_VERSION);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spdm_get_capabilities(int dev_no)
> +{
> +	struct spdm_header request = {};
> +	int ret;
> +
> +	request.version = SPDM_VERSION;
> +	request.code = SPDM_GET_CAPABILITIES;
> +	request.param1 = SPDM_RSVD;
> +	request.param2 = SPDM_RSVD;
> +
> +	ret = sdsi_process_spdm(&request, NULL, sizeof(request), 0, dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Failed GET_CAPABILITIES\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct spdm_negotiate_alg {
> +	struct spdm_header header;
> +	uint32_t	length:16;
> +	uint32_t	measurement_specification:8;
> +	uint32_t	reserved:8;
> +	uint32_t	base_asym_algo;
> +	uint32_t	base_hash_algo;
> +	uint32_t	reserved2[3];
> +	uint32_t	ext_asym_count:8;
> +	uint32_t	ext_hash_count:8;
> +	uint32_t	reserved3:16;
> +} __packed;

I'd expect this to not need __packed.

> +#define MEASUREMENT_SPEC_DMTF			BIT(0)
> +#define BASE_ASYM_ALG_ECDSA_ECC_NIST_P384	BIT(7)
> +#define BASE_HASH_ALG_SHA_384			BIT(1)
> +
> +static int spdm_negotiate_algorithms(int dev_no)
> +{
> +	struct spdm_negotiate_alg request = {};
> +	int ret;
> +
> +	request.header.version = SPDM_VERSION;
> +	request.header.code = SPDM_NEGOTIATE_ALGORITHMS;
> +	request.header.param1 = SPDM_RSVD;
> +	request.header.param2 = SPDM_RSVD;
> +
> +	request.length = sizeof(request);
> +	request.measurement_specification = MEASUREMENT_SPEC_DMTF;
> +	request.base_asym_algo = BASE_ASYM_ALG_ECDSA_ECC_NIST_P384;
> +	request.base_hash_algo = BASE_HASH_ALG_SHA_384;
> +
> +	ret = sdsi_process_spdm(&request, NULL, sizeof(request), 0, dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Failed NEGOTIATE_ALGORITHMS\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spdm_negotiate(int dev_no)
> +{
> +	int ret;
> +
> +	ret = spdm_get_version(dev_no);
> +	if (ret)
> +		return ret;
> +
> +	ret = spdm_get_capabilities(dev_no);
> +	if (ret)
> +		return ret;
> +
> +	return spdm_negotiate_algorithms(dev_no);
> +}
> +
> +struct get_digests_response {
> +	struct spdm_header header;
> +	uint8_t digest[TPM_ALG_SHA_384_SIZE];
> +};
> +
> +#define SLOT_MASK(slot) BIT(slot)
> +
> +int spdm_get_digests(int dev_no, uint8_t digest[TPM_ALG_SHA_384_SIZE])
> +{
> +	struct spdm_header request = {};
> +	struct get_digests_response response = {};
> +	int ret;
> +
> +	ret = spdm_negotiate(dev_no);
> +	if (ret)
> +		return ret;
> +
> +	request.version = SPDM_VERSION;
> +	request.code = SPDM_GET_DIGESTS;
> +	request.param1 = SPDM_RSVD;
> +	request.param2 = SPDM_RSVD;
> +
> +	ret = sdsi_process_spdm(&request, &response, sizeof(request),
> +				sizeof(response), dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Failed GET_DIGESTS\n");
> +		return ret;
> +	}
> +
> +	if (!(response.header.param2 & SLOT_MASK(0))) {
> +		fprintf(stderr, "Error, Slot 0 not selected in GET_DIGESTS\n");
> +		return -1;
> +	}
> +
> +	if (digest)
> +		memcpy(digest, response.digest, TPM_ALG_SHA_384_SIZE);
> +
> +	return 0;
> +}
> +
> +#define CERT_SLOT	0
> +#define CERT_BUF_LEN	4096
> +
> +struct get_cert_request {
> +	struct spdm_header header;
> +	uint16_t offset;
> +	uint16_t length;
> +} __packed;
> +
> +struct get_cert_response {
> +	struct spdm_header header;
> +	uint16_t portion_length;
> +	uint16_t remainder_length;
> +	uint8_t certificate_chain[CERT_BUF_LEN];
> +} __packed;

Neither of these needs packed?


-- 
 i.

> +static int get_certificate_size(int dev_no)
> +{
> +	struct get_cert_request request = {};
> +	struct get_cert_response response = {};
> +	int ret;
> +
> +	request.header.version = SPDM_VERSION;
> +	request.header.code = SPDM_GET_CERTIFICATE;
> +	request.header.param1 = CERT_SLOT;
> +	request.header.param2 = SPDM_RSVD;
> +	request.offset = 0;
> +	request.length = CERT_BUF_LEN;
> +
> +	ret = sdsi_process_spdm(&request, &response, sizeof(request),
> +				sizeof(response), dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Error getting size during GET_CERTIFICATE\n");
> +		return ret;
> +	}
> +
> +	return response.portion_length + response.remainder_length;
> +}
> +
> +static int get_certificate_portion(int dev_no, uint16_t offset, uint16_t length,
> +				   uint16_t *portion_length, uint16_t *remainder_length,
> +				   uint8_t *cert_chain)
> +{
> +	struct get_cert_request request = {};
> +	struct get_cert_response response = {};
> +	int ret;
> +
> +	request.header.version = SPDM_VERSION;
> +	request.header.code = SPDM_GET_CERTIFICATE;
> +	request.header.param1 = CERT_SLOT;
> +	request.header.param2 = SPDM_RSVD;
> +	request.offset = offset;
> +	request.length = length;
> +
> +	ret = sdsi_process_spdm(&request, &response, sizeof(request),
> +				sizeof(response), dev_no);
> +	if (ret) {
> +		fprintf(stderr, "Failed GET_CERTIFICATE\n");
> +		return ret;
> +	}
> +
> +	*portion_length = response.portion_length;
> +	*remainder_length = response.remainder_length;
> +
> +	memcpy(cert_chain + offset, response.certificate_chain, *portion_length);
> +
> +	return 0;
> +}
> +
> +int spdm_get_certificate(int dev_no, struct cert_chain *c)
> +{
> +	uint16_t remainder_length = CERT_BUF_LEN;
> +	uint16_t portion_length = 0;
> +	uint16_t offset = 0;
> +	int ret, size;
> +
> +	ret = spdm_negotiate(dev_no);
> +	if (ret)
> +		return ret;
> +
> +	ret = spdm_get_digests(dev_no, NULL);
> +	if (ret)
> +		return ret;
> +
> +	size = get_certificate_size(dev_no);
> +	if (size < 0)
> +		return size;
> +
> +	c->chain = malloc(size);
> +	if (!c->chain) {
> +		perror("malloc");
> +		return -1;
> +	}
> +
> +	while (remainder_length) {
> +		int length;
> +
> +		if (remainder_length > CERT_BUF_LEN)
> +			length = CERT_BUF_LEN;
> +		else
> +			length = remainder_length;
> +
> +		offset += portion_length;
> +
> +		ret = get_certificate_portion(dev_no, offset, length,
> +					      &portion_length,
> +					      &remainder_length,
> +					      c->chain);
> +		if (ret < 0)
> +			goto free_cert_chain;
> +	}
> +
> +	c->len = offset + portion_length;
> +	return 0;
> +
> +free_cert_chain:
> +	free(c->chain);
> +	c->chain = NULL;
> +	return ret;
> +}
> diff --git a/tools/arch/x86/intel_sdsi/spdm.h b/tools/arch/x86/intel_sdsi/spdm.h
> new file mode 100644
> index 000000000000..aa7e08ffb872
> --- /dev/null
> +++ b/tools/arch/x86/intel_sdsi/spdm.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdint.h>
> +
> +#define TPM_ALG_SHA_384_SIZE 48
> +
> +struct cert_chain {
> +	void *chain;
> +	size_t len;
> +};
> +
> +int spdm_get_digests(int dev_no, uint8_t digest[TPM_ALG_SHA_384_SIZE]);
> +int spdm_get_certificate(int dev_no, struct cert_chain *c);
> +
> 


